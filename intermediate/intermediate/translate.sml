structure Translate :> TRANSLATE =
struct

structure Frame : FRAME = MipsFrame
structure T = Tree
structure A = Absyn




datatype exp = Ex of T.exp
             | Nx of T.stm
             | Cx of Temp.label * Temp.label -> T.stm

datatype level = Top
               | Sub of {parent: level, frame: Frame.frame, unique: unit ref}

type access = level * Frame.access

type frag = Frame.frag

(* helpers *)

val frags: frag list ref = ref [] 

fun seq stmts =
  case stmts of
    [s] => s
  | [s1, s2] => T.SEQ (s1, s2)
  | stm::slist => T.SEQ (stm, seq(slist))
  | _ => ErrorMsg.impossible "Empty sequence list received"


fun followStatics (ctx, Top, _, _) = ErrorMsg.impossible 
                                      ("Item not found in static link chain (" ^ ctx ^ ")")
  | followStatics (ctx, _, Top, _) = ErrorMsg.impossible 
                                      ("Item not found in static link chain (" ^ ctx ^ ")")
  | followStatics (ctx, defLevel, useLevel, base) = 
      let 
        val Sub {parent=usepar, frame=usefra, unique=useuniq} = useLevel
        val Sub {parent=defpar, frame=deffra, unique=defuniq} = defLevel
      in
        if (defuniq = useuniq)
        then base
        else 
          let 
            val static = hd (Frame.formals usefra)
          in
            followStatics (ctx, defLevel, usepar, Frame.exp static base)
          end
      end


fun unEx (Ex e) = e
  | unEx (Cx genstm) =
      let 
        val r = Temp.newtemp()
        val t = Temp.newlabel()
        val f = Temp.newlabel()
      in 
        T.ESEQ(seq[T.MOVE(T.TEMP r, T.CONST 1),
                   genstm(t,f),
                   T.LABEL f,
                   T.MOVE(T.TEMP r, T.CONST 0),
                   T.LABEL t], 
               T.TEMP r)
      end
  | unEx (Nx s) = T.ESEQ(s, T.CONST 0)

fun unCx (Ex (T.CONST 0)) = (fn (t, f) => T.JUMP(T.NAME f, [f]))
  | unCx (Ex (T.CONST 1)) = (fn (t, f) => T.JUMP(T.NAME t, [t]))
  | unCx (Ex e) = (fn (t, f) => T.CJUMP(T.NE, e, T.CONST 0, t, f))
  | unCx (Cx genstm) = genstm
  | unCx (Nx _) = ErrorMsg.impossible "Cannot unCx an Nx"

fun unNx (Ex e) = T.EXP e
  | unNx (Cx genstm) = T.EXP(unEx(Cx genstm))
  | unNx (Nx n) = n

val outermost = Top

fun clear() = frags := []

fun newLevel {parent, name, formals} = 
  Sub({parent = parent, frame = Frame.newFrame({name=name, formals=(true::formals)}), unique = ref ()})

fun formals level = 
  case level of
    Top => nil
  | Sub({parent, frame, unique}) => 
      let 
        val tail = tl (Frame.formals frame) 
      in
        map (fn acc => (level, acc)) tail 
      end

fun allocLocal level esc = 
  case level of 
    Top => ErrorMsg.impossible "Cannot alloc locals to outermost level"
  | Sub({parent, frame, unique}) => (level, Frame.allocLocal frame esc)

fun procEntryExit {level = level, body = body} = 
  case level of 
    Top => ErrorMsg.impossible "Cannot procEntryExit outermost level"
  | Sub({parent, frame, unique}) =>
      let
        val moveBody = T.MOVE(T.TEMP Frame.RV, unEx body)
        val procBody = Frame.procEntryExit1(frame, moveBody)
      in
        frags := Frame.PROC({body=procBody, frame=frame})::(!frags)
      end

fun getResult() = !frags

fun printResult outstream = 
  (print ("RV: " ^ (Temp.makestring Frame.RV) ^ "\n");
   List.app (fn frag => Frame.printFrag(outstream, frag)) (!frags))

(* Variables *)
fun simpleVar (dec, useLevel) = 
  let
    val (declvl, decacc) = dec
    val () = print (Frame.accessToStr decacc)
    val () = print "\n"
  in
    Ex(Frame.exp decacc (followStatics("simpleVar", declvl, useLevel, T.TEMP Frame.FP)))
  end

fun subscriptVar (addr, index) =
  let
     val valid = Temp.newlabel()
     val invalid = Temp.newlabel()
     val exit = Temp.newlabel()
     val r = Temp.newtemp()
     val sizeExp = T.MEM(T.BINOP(T.MINUS, unEx addr, T.CONST Frame.wordSize))
   in 
    Ex(T.ESEQ(seq [
        T.CJUMP (T.LT, unEx index, sizeExp, valid, invalid),
        T.LABEL valid,
        T.MOVE(T.TEMP r,
               T.MEM(T.BINOP(T.PLUS, 
                             unEx addr, 
                             T.BINOP(T.MUL, 
                                     unEx index, 
                                     T.CONST (Frame.wordSize))))),
        T.JUMP (T.NAME exit, [exit]),
        T.LABEL invalid,
        T.MOVE(T.TEMP r, Frame.externalCall("arrayOutOfBounds", [])),
        T.LABEL exit], 
      T.TEMP r))
  end



fun fieldVar (addr, offset) = 
  Ex(T.MEM(T.BINOP(T.PLUS, 
                   unEx addr, 
                   T.BINOP(T.MUL, 
                           T.CONST(offset), 
                           T.CONST (Frame.wordSize)))))





(* expressions *)

fun binop (oper, e1, e2) =
  let
    val left = unEx e1
    val right = unEx e2
    val toper =
      case oper of
        A.PlusOp => T.PLUS
      | A.MinusOp => T.MINUS
      | A.TimesOp => T.MUL
      | A.DivideOp => T.DIV
      | _ => ErrorMsg.impossible "Unidentified binop received"
  in 
    Ex(T.BINOP(toper, left, right))
  end

fun relop (oper, e1, e2) =
  let
    val left = unEx e1
    val right = unEx e2
    val toper =
      case oper of
        A.EqOp => T.EQ
      | A.NeqOp => T.NE
      | A.LtOp => T.LT
      | A.LeOp => T.LE
      | A.GtOp => T.GT
      | A.GeOp => T.GE
      | _ => ErrorMsg.impossible "Unidentified relop received"
  in 
    Cx((fn (t, f) => T.CJUMP(toper, left, right, t, f))) 
  end


fun ifThenExp(testExp, thenExp) = 
  let
    val r = Temp.newtemp()
    val t = Temp.newlabel()
    val f = Temp.newlabel()
  in
    Nx (seq[unCx testExp (t, f),
            T.LABEL t,
            unNx thenExp,
            T.LABEL f])
  end

(*detect special cases and handle accordingly*)
fun ifThenElseExp(testExp, thenExp, elseExp) = 
  let
    val r = Temp.newtemp()
    val t = Temp.newlabel()
    val f = Temp.newlabel()
    val exit = Temp.newlabel()
  in
    Ex (T.ESEQ(seq[unCx testExp (t, f),
                   T.LABEL t,
                   T.MOVE(T.TEMP r, unEx thenExp),
                   T.JUMP(T.NAME(exit), [exit]),
                   T.LABEL f,
                   T.MOVE(T.TEMP r, unEx elseExp),
                   T.LABEL exit],
               T.TEMP r))
  end

fun assignExp (left, right) = Nx(T.MOVE(unEx(left), unEx(right)))

fun breakExp (label) = Nx(T.JUMP(T.NAME label, [label]))

fun seqExp [] = Ex(T.CONST 0)
  | seqExp [exp] = exp
  | seqExp (exp::exps) = Ex(T.ESEQ (unNx exp, unEx (seqExp exps)))

fun letExp ([], body) = body
  | letExp (decs, body) = Ex(T.ESEQ (seq (map unNx decs), unEx body))

fun whileExp(test, body, exit) =
  let
    val start = Temp.newlabel()
  in
    Nx (seq[(unCx test (start, exit)),
             T.LABEL start,
             unNx body,
             unCx test (start, exit),
             T.LABEL exit])
  end

fun forExp(idxExp, loExp, hiExp, body, exit) = 
  let 
    val index = unEx idxExp
    val lo = unEx loExp
    val hi = unEx hiExp
    val start = Temp.newlabel()
    val increment = Temp.newlabel()
  in
    Nx(seq [T.MOVE (index, lo),
            T.CJUMP (T.LE, index, hi, start, exit),
            T.LABEL start,
            unNx body,
            T.CJUMP (T.LT, index, hi, increment, exit),
            T.LABEL increment,
            T.MOVE (index, T.BINOP (T.PLUS, index, T.CONST 1)),
            T.JUMP (T.NAME start, [start]),
            T.LABEL exit])
  end

fun recordExp(fields) = 
  let
    val len = length fields
    val r = Temp.newtemp()
    val allocRecord = T.MOVE(T.TEMP r, Frame.externalCall("malloc", [T.CONST (len * Frame.wordSize)]))
    fun allocFields ([], index) = []
      | allocFields (exp::explist, index) = (
          T.MOVE(T.MEM(T.BINOP(T.PLUS, 
                               T.TEMP(r), 
                               T.CONST(index * Frame.wordSize))), unEx exp)
          )::allocFields(explist, index+1) 
  in
    Ex (T.ESEQ(T.SEQ(allocRecord, seq (allocFields (fields, 0))), T.TEMP r))
  end


fun arrayExp(sizeExp, initExp) = 
  let
    val r = Temp.newtemp()
    val size = Temp.newtemp()

    val putToSizeTemp = T.MOVE(T.TEMP size, T.BINOP(T.MUL, unEx sizeExp, T.CONST Frame.wordSize))

    val actualSizeExp = T.BINOP(T.PLUS, T.TEMP size, T.CONST Frame.wordSize)
    val allocArray = T.MOVE(T.TEMP r, Frame.externalCall("initArray", [actualSizeExp, unEx initExp]))

    val putSizeInArr = T.MOVE(T.MEM(T.TEMP r), T.TEMP size)
  in
    Ex(T.ESEQ(seq[
        putToSizeTemp,
        allocArray,
        putSizeInArr
      ],
      T.BINOP(T.PLUS, T.TEMP r, T.CONST Frame.wordSize))) (* give pointer to a[1] instead of a[0]*)
  end



fun callExp (label, useLevel, defLevel, args) = 
  case defLevel of 
    Top => Ex(Frame.externalCall(Symbol.name label, map unEx args))
  | Sub({parent,frame,unique}) =>
      let 
        val sl = followStatics("callExp", defLevel, useLevel, T.TEMP Frame.FP)
      in 
        Ex(T.CALL(T.NAME label, sl::(map unEx args)))
      end

fun intLit n = Ex(T.CONST n)

fun nilLit() = Ex(T.CONST 0)

fun strLit s = 
  let 
    val l = Temp.newlabel()
  in 
    frags := (Frame.STRING(l, s))::(!frags);
    Ex(T.NAME l)
  end


fun stringEQ (e1, e2) =  Ex(Frame.externalCall("stringEqual", [unEx e1,unEx e2]))

fun stringNEQ (e1, e2) = Ex(T.BINOP(T.XOR, unEx (stringEQ(e1, e2)), T.CONST(1)))

end
