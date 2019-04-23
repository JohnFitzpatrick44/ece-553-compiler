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
  val calldefs = [FP, RV, RA]@callersaves
	
  val tempMap = 
    let
      fun add ((s, r), t) = Temp.Map.insert (t, r, s) 
    in
      foldl add Temp.Map.empty (specialregspairs@argregspairs@calleesavespairs@callersavespairs)
    end

	val registers = map (fn (s, r) => s) (specialregspairs @ argregspairs @ calleesavespairs @ callersavespairs)

  datatype access = InFrame of int
                  | InReg of Temp.temp

  type frame = {name: Temp.label, formals: access list, frameSize: int ref}

  val wordSize = 4
  val aRegs = 4

  (* copied over from translate *)
  fun seq stmts =
    case stmts of
      [s] => s
    | [s1, s2] => Tree.SEQ (s1, s2)
    | stm::slist => Tree.SEQ (stm, seq(slist))
    | _ => ErrorMsg.impossible "Empty sequence list received"



  fun newFrame({name = name, formals = formals}) = 
    let 
      val totalOffset = ref 0
      fun allocFormals([], offset, unescaped) = []
        | allocFormals(escape::elist, offset, unescaped) = 
            if ((not escape) andalso (unescaped < aRegs))
            then InReg(Temp.newtemp())::allocFormals(elist, offset, unescaped + 1)
            else (* totalOffset := !totalOffset + wordSize; InFrame(offset - wordSize)::allocFormals(elist, offset - wordSize, unescaped) *)
              ErrorMsg.impossible "Spilled arguments not implemented."
    in
      {name = name, formals = allocFormals(formals, 0, 0), frameSize = totalOffset}
    end

  fun name({name = name, formals = _ , frameSize = _}) = name

  fun formals({name = _, formals = formals , frameSize = _}) = formals

  fun allocLocal fr esc = 
    let 
      fun incrementOffset {name=_, formals=_, frameSize = offset} = offset := !offset + wordSize
      fun getOffset       {name=_, formals=_, frameSize = offset} = !offset
    in 
      if esc
      then (incrementOffset fr; InFrame(0 - (getOffset fr)))
      else InReg(Temp.newtemp())
    end

  fun exp (InReg t) e = Tree.TEMP(t)
    | exp (InFrame offset) e = Tree.MEM(Tree.BINOP(Tree.PLUS, e, Tree.CONST(offset)))


  fun intToString i = if i < 0 then "-"^(Int.toString (0-i)) else Int.toString i

  fun fetchInstr(InFrame offset) = "lw `d0, " ^ (intToString offset) ^ "($fp)\n"
  fun storeInstr(InFrame offset) = "sw `s0, " ^ (intToString offset) ^ "($fp)\n"

  fun externalCall (s,args) = Tree.CALL(Tree.NAME(Temp.namedlabel s), args)

  
  (* Regalloc spills calleesaves if necessary *)
  fun procEntryExit1 (frame, stm) = 
    let 
      val viewShift = 
        let
          fun makeStm(access, reg) = Tree.MOVE(exp access (Tree.TEMP FP), Tree.TEMP reg)
        in
          (* !!! need to handle case where argument is in memory *)
          map makeStm (ListPair.zip(formals frame, argregs))
        end

      fun allocReg (reg) = (reg, allocLocal frame false)
      val regAccess = map allocReg (RA::calleesaves)
      fun shiftToMem (reg, access) = Tree.MOVE(exp access (Tree.TEMP FP), Tree.TEMP reg)
      fun shiftToTemp (reg, access) = Tree.MOVE(Tree.TEMP reg, exp access (Tree.TEMP FP))
    in
      seq(viewShift @ (map shiftToMem regAccess) @ [stm] @ (map shiftToTemp regAccess))
    end
    
	fun procEntryExit2 (frame, body) = 
		body @ [Assem.OPER{assem="", 
										 	 src=[ZERO, RA, SP, FP, RV] @ calleesaves, 
											 dst=[], 
											 jump=SOME []}]


	fun procEntryExit3({name,formals,frameSize}, body) =
		{prolog = Symbol.name name ^ ":\n" ^ 
              "sw $fp 0($sp)\n" ^ 
              "move $fp $sp\n" ^ 
              "addiu $sp $sp -" ^ (Int.toString (!frameSize)) ^ "\n",
		 body = body,
		 epilog = "move $sp $fp\n" ^ 
              "lw $fp 0($sp)\n" ^ 
              "jr $ra\n"}	


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

  fun string (label, str) = Symbol.name label ^ ": .asciiz \"" ^ str ^ "\"\n"

end
