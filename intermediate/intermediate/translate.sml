structure Translate =
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





fun seq stmts =
  case stmts of
    [s] => s
  | [s1, s2] => T.SEQ(s1, s2)
  | stm::slist => T.SEQ(stm, seq(slist))





(* From book *)
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

fun unCx (Ex (T.CONST 0)) = fn (t, f) => T.JUMP(T.NAME f, [f])
  | unCx (Ex (T.CONST 1)) = fn (t, f) => T.JUMP(T.NAME t, [t])
  | unCx (Ex e) = fn (t, f) => T.CJUMP(T.NE, e, T.CONST 0, t, f)
  | unCx (Cx genstm) = genstm
  | unCx (Nx _) = () (* THROW ERROR..? *)

fun unNx (Ex e) = T.EXP e
  | unNx (Cx genstm) = T.EXP(unEx(Cx genstm))
  | unNx (Nx n) = n









fun binOp (oper, e1, e2) =
  let
    val left = unEx e1
    val right = unEx e2
    val toper =
      case oper of
        A.PlusOp => T.PLUS
      | A.MinusOp => T.MINUS
      | A.TimesOp => T.MUL
      | A.DivideOp => T.DIV
  in 
    Ex(T.BINOP(toper,left,right))
  end

fun compOp (oper, e1, e2) =
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

fun forExp(indexExp, loExp, hiExp, body, exit) = 
  let 
    val index = unEx indexExp
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

fun intLit n = Ex(T.CONST n)

fun strLit s = (*???*)()

fun nilLit () = Ex(T.CONST 0)















(*unsure about this*)
fun followStatics ((Top, _), _, _) = (*ERROR*) ()
  | followStatics (_, Top, _) = (*ERROR*) ()
  | followStatics ((decLvl, decAcc), useLvl, acc) = 
      let 
        val Sub({usepar, usefra, useuniq}) = useLvl
        val Sub({decpar, decfra, decuniq}) = decLvl
      in
        if(decuniq = useuniq)
        then Frame.exp decAcc acc
        else 
          let 
            val static = hd(Frame.formals usefra)
          in
            followStatics ((decLvl, decAcc), usepar, Frame.exp static acc)
          end
      end


fun simpleVar (dec, useLevel) = Ex(followStatics(dec, useLevel, T.TEMP Frame.FP))


fun subscriptVar (name, index) = 
  Ex(T.MEM(T.BINOP(T.PLUS, 
                   unEx name, 
                   T.BINOP(T.MUL, 
                           unEx index, 
                           T.CONST (Frame.wordSize)))))

fun fieldVar (name, offset) = 
  Ex(T.MEM(T.BINOP(T.PLUS, 
                   unEx name, 
                   T.BINOP(T.MUL, 
                           T.CONST(index), 
                           T.CONST (Frame.wordSize)))))

end