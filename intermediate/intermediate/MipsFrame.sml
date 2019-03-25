structure MipsFrame :> FRAME = 
struct

  datatype access = InFrame of int
                  | InReg of Temp.temp

  type frame = {name: Temp.label, formals: access list, frameSize: int ref}


  val wordSize = 4
  val aRegs = 4

  fun newFrame({name = name, formals = formals}) = 
    let 
      val totalOffset = ref 0
      fun allocFormals([], offset, unescaped) = []
        | allocFormals(escape::elist, offset, unescaped) = 
            if ((not escape) andalso (unescaped < aRegs))
            then InReg(Temp.newtemp())::allocFormals(elist, offset, unescaped + 1)
            else (totalOffset := !totalOffset + wordSize; InFrame(offset - wordSize)::allocFormals(elist, offset - wordSize, unescaped))
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

  fun exp (InReg t) exp = Tree.TEMP(t)
    | exp (InFrame offset) exp = Tree.MEM(Tree.BINOP(Tree.PLUS, exp, Tree.CONST(offset)))
  
  fun procEntryExit1 (frame, stm) = stm (* to be implemented in a later phase *)

  fun externalCall (s,args) = Tree.CALL(Tree.NAME(Temp.namedlabel s), args)

  val FP = Temp.newtemp()
  val RV = Temp.newtemp()

  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string

  fun accessToStr(InFrame(offset)) = "InFrame(" ^ (Int.toString offset) ^ ")"
    | accessToStr(InReg(t)) = Temp.makestring t

  fun printFrag(outstream, PROC{body, frame}) = 
      (TextIO.output(outstream, "-----FRAG("^(Symbol.name(name frame))^")-----\n");
       TextIO.output(outstream, "args: ");
       TextIO.output(outstream, String.concatWith ", " (map accessToStr (formals frame)));
       TextIO.output(outstream, "\n");
       Printtree.printtree(outstream, body))
    | printFrag(outstream, STRING(label, str)) = 
        TextIO.output(outstream, "----- STR FRAG(" ^ (Symbol.name label) ^ ")----\n" ^ str ^ "\n")

  (* TODO *)
  fun string (label, str) = Symbol.name label ^ str

end
