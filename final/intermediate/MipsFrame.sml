structure MipsFrame : FRAME = 
struct
	(* register list *) 
	type register = string

	val ZERO = Temp.newtemp()
	val RA = Temp.newtemp()
	val SP = Temp.newtemp()
  val FP = Temp.newtemp()
  val RV = Temp.newtemp()

	val A0 = Temp.newtemp()
	val A1 = Temp.newtemp()
	val A2 = Temp.newtemp()
	val A3 = Temp.newtemp()

	val S0 = Temp.newtemp()
	val S1 = Temp.newtemp()
	val S2 = Temp.newtemp()
	val S3 = Temp.newtemp()
	val S4 = Temp.newtemp()
	val S5 = Temp.newtemp()
	val S6 = Temp.newtemp()
	val S7 = Temp.newtemp()

	val T0 = Temp.newtemp()
	val T1 = Temp.newtemp()
	val T2 = Temp.newtemp()
	val T3 = Temp.newtemp()
	val T4 = Temp.newtemp()
	val T5 = Temp.newtemp()
	val T6 = Temp.newtemp()
	val T7 = Temp.newtemp()
	val T8 = Temp.newtemp()
	val T9 = Temp.newtemp()

	val specialregspairs = [("$ra", RA), ("$v0", RV), ("$sp", SP), ("$fp", FP), ("$0", ZERO)]
	val argregspairs = [("$a0", A0), ("$a1", A1), ("$a2", A2), ("$a3", A3)]
	val calleesavespairs = [("$s0", S0), ("$s1", S1), ("$s2", S2), ("$s3", S3),
										 ("$s4", S4), ("$s5", S5), ("$s6", S6), ("$s7", S7)]
	val callersavespairs = [("$t0", T0), ("$t1", T1), ("$t2", T2), ("$t3", T3), ("$t4", T4), 
										("$t5", T5), ("$t6", T6), ("$t7", T7), ("$t8", T8), ("$t9", T9)]

  val specialregs = map (fn (s, r) => r) specialregspairs
  val argregs = map (fn (s, r) => r) argregspairs
  val calleesaves = map (fn (s, r) => r) calleesavespairs
  val callersaves = map (fn (s, r) => r) callersavespairs
  val calldefs = [RV, RA]@callersaves
	
  val tempMap = 
    let
      fun add ((s, r), t) = Temp.Map.insert (t, r, s) 
    in
      foldl add Temp.Map.empty (specialregspairs@argregspairs@calleesavespairs@callersavespairs)
    end

	val registers = map (fn (s, r) => s) (callersavespairs @ calleesavespairs @ argregspairs @ specialregspairs)
  val nonZeroRegisters = map (fn (s, r) => s) (callersavespairs @ calleesavespairs @ argregspairs @ [("$ra", RA), ("$v0", RV), ("$sp", SP), ("$fp", FP)])

  datatype access = InFrame of int
                  | InReg of Temp.temp

  type frame = {name: Temp.label, formals: access list, frameSize: int ref, parentSize: int option}

  val wordSize = 4
  val aRegs = 4

  (* copied over from translate *)
  fun seq stmts =
    case stmts of
      [s] => s
    | [s1, s2] => Tree.SEQ (s1, s2)
    | stm::slist => Tree.SEQ (stm, seq(slist))
    | _ => ErrorMsg.impossible "Empty sequence list received"


  fun getFrameSize({name=_, formals=_, frameSize = fs, parentSize = _}) = !fs 

  fun newFrame({name = name, formals = formals, parentSize = parentSize}) = 
    let 
      fun boolToString(true) = "true"
        | boolToString(false) = "false"
      val _ = print ((Temp.labelString name) ^ ": " ^ (String.concatWith ", " (map boolToString formals)) ^ "\n" ) 

      val totalOffset = ref 4 (* save a space for previous fp, which isn't necessarily the same as the static link
                                 might cause problems with static links because translate.sml seems to rely on the assumption that static links are at 0(FP) *)
      fun allocFormals([], offset, unescaped) = []
        | allocFormals(escape::elist, offset, unescaped) = 
            if ((not escape) andalso (unescaped < aRegs))
            then InReg(Temp.newtemp())::allocFormals(elist, offset, unescaped + 1)
            else (totalOffset := !totalOffset + wordSize; InFrame(0-(!totalOffset))::allocFormals(elist, offset - wordSize, unescaped) )
    in
      {name = name, formals = allocFormals(formals, 0, 0), frameSize = totalOffset, parentSize = parentSize}
    end

  fun name({name = name, formals = _ , frameSize = _, parentSize = _}) = name

  fun formals({name = _, formals = formals , frameSize = _, parentSize = _}) = formals

  fun allocLocal fr esc = 
    let 
      fun incrementOffset {name=_, formals=_, frameSize = offset, parentSize = _} = offset := !offset + wordSize
      fun getOffset       {name=_, formals=_, frameSize = offset, parentSize = _} = !offset
    in 
      if esc
      then (incrementOffset fr; InFrame(0 - (getOffset fr)))
      else InReg(Temp.newtemp())
    end

  fun exp (InReg t) e = Tree.TEMP(t)
    | exp (InFrame offset) e = Tree.MEM(Tree.BINOP(Tree.PLUS, e, Tree.CONST(offset)))


  fun intToString i = if i < 0 then "-"^(Int.toString (0-i)) else Int.toString i

  fun fetchInstr(InFrame offset) = "lw `d0, " ^ (intToString offset) ^ "(`s0)\n"
  fun storeInstr(InFrame offset) = "sw `s0, " ^ (intToString offset) ^ "(`s1)\n"

  fun externalCall (s,args) = Tree.CALL(Tree.NAME(Temp.namedlabel ("tig_" ^ s)), rev args)

  
  (* Regalloc spills calleesaves if necessary *)

  fun procEntryExit1 (frame, stm) = 
    let 
      val viewShift = 
        let
          val index = ref ~1
          fun makeStm(access) = (index := !index + 1; 
                                if !index < 4 then 
                                  Tree.MOVE(exp access (Tree.TEMP FP), Tree.TEMP (List.nth(argregs, !index)))
                                else 
                                  Tree.MOVE(exp access (Tree.TEMP FP), exp (InFrame((3-(!index))*wordSize)) (Tree.TEMP FP)))
        in
          map makeStm (rev (formals frame))
        end


      fun allocReg (reg) = (reg, allocLocal frame false)
      val regAccess = map allocReg (RA::calleesaves)
      fun shiftToMem (reg, access) = Tree.MOVE(exp access (Tree.TEMP FP), Tree.TEMP reg)
      fun shiftToTemp (reg, access) = Tree.MOVE(Tree.TEMP reg, exp access (Tree.TEMP FP))
    in
      seq(viewShift @ (map shiftToMem regAccess) @ [stm] @ (map shiftToTemp regAccess))
    end


  (*
  fun procEntryExit1 (frame, stm) = let

    fun getOffset(access) = 
      case access of
        InFrame(offset) => offset
      | _ => ErrorMsg.impossible "Argument could not be allocated."

    val viewShift = 
      let
        val index = ref ~1
        fun makeStm(access) = (index := !index + 1; 
                              if !index < 4 then 
                                Tree.MOVE(exp access (Tree.TEMP FP), Tree.TEMP (List.nth(argregs, !index)))
                              else 
                                Tree.MOVE(exp access (Tree.TEMP FP), exp (InFrame((3-(!index))*wordSize)) (Tree.TEMP FP)))
      in
        map makeStm (rev (formals frame))
      end

    (* View shift in frame arguments *)
    fun shiftToMem (reg, (statements, accesses)) = 
      let
        val access = allocLocal frame true
        val statement = Tree.MOVE(Tree.MEM(Tree.BINOP(Tree.PLUS, Tree.TEMP(FP), Tree.CONST (getOffset access))), Tree.TEMP reg)
      in
        (statement::statements, (access, reg)::accesses)
      end

    val (toMemStatements, argAccesses) = foldr shiftToMem ([], []) (RA::calleesaves)    (* foldr as lists are reversed *)

    fun shiftToTemp (access, reg) = Tree.MOVE(Tree.TEMP reg, Tree.MEM(Tree.BINOP(Tree.PLUS, Tree.TEMP(FP), Tree.CONST (getOffset access))))

    val toTempStatements = map shiftToTemp argAccesses 
  in
    seq(viewShift @ toMemStatements @ [stm] @ toTempStatements)
  end
  *)
    
	fun procEntryExit2 (frame, body) = body (* Deprecated: merged with procEntryExit3 epilog *)

	fun procEntryExit3({name,formals,frameSize,parentSize}, body) =
    {
      prolog=[Assem.LABEL{assem=(Symbol.name name) ^ ":\n", lab=name},
              Assem.OPER{assem="sw `s0, 0(`s1)\n", dst=[], src=[FP, SP], jump=NONE},
              Assem.MOVE{assem="move `d0, `s0\n", dst=FP, src=SP},
              Assem.OPER{assem="addiu `d0, `s0, -" ^ (Int.toString (!frameSize+4)) ^ "\n", dst=[SP], src=[SP], jump=NONE}],
      body= body,
      epilog=[Assem.OPER{assem="", src=[ZERO, RA, SP, RV] @ calleesaves, dst=[], jump=NONE},
              Assem.MOVE{assem="move `d0, `s0\n", dst=SP, src=FP},
              Assem.OPER{assem="lw `d0, 0(`s0)\n", dst=[FP], src=[SP], jump=NONE},
              Assem.OPER{assem="jr `s0\n", dst=[], src=[RA], jump=NONE}]
    }

  val tempMap = foldl (fn ((r, t), table) => Temp.Map.insert(table, t, r)) Temp.Map.empty (specialregspairs@argregspairs@calleesavespairs@callersavespairs)

  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string

  fun accessToStr(InFrame(offset)) = "InFrame(" ^ (Int.toString offset) ^ ")"
    | accessToStr(InReg(t)) = case Temp.Map.find(tempMap,t) of
                                SOME(r) => r
                              | NONE => Temp.makestring t 

  fun printFrag(outstream, PROC{body, frame}) = 
      (TextIO.output(outstream, "-----FRAG("^(Symbol.name(name frame))^")-----\n");
       TextIO.output(outstream, "args: ");
       TextIO.output(outstream, String.concatWith ", " (map accessToStr (formals frame)));
       TextIO.output(outstream, "\n");
       Printtree.printtree(outstream, body))
    | printFrag(outstream, STRING(label, str)) = 
        TextIO.output(outstream, "----- STR FRAG(" ^ (Symbol.name label) ^ ")----\n" ^ str ^ "\n")

  fun string (label, str) = Symbol.name label ^ ":\n.word "^(Int.toString(size(str))) ^ "\n.ascii \"" ^ str ^ "\"\n"

end
