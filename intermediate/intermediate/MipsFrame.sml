structure MipsFrame :> FRAME = 
struct

  type frame = {name: Temp.label, formals: access list, frameSize: int ref}

  datatype access = InFrame of int
                  | InReg of Temp.temp


  val aRegs = 4

  fun newFrame({name = name, formals = formals}) = 
    let 
      fun allocFormals([], offset, unescaped) = []
        | allocFormals(escape::elist, offset, unescaped) = 
            let
              val totalOffset = ref 0
            in
              if ((not escape) andalso (unescaped < aRegs))
              then InReg(Temp.newtemp())::allocFormals(elist, offset, unescaped + 1)
              else (totalOffset := !totalOffset + wordSize; InFrame(offset - wordSize)::allocFormals(elist, offset - wordSize, unescaped))
            end
    in
      {name = name, formals = allocFormals(formals, 0, 0), totalOffset}
    end


  fun name({name = name, formals = _ , frameSize = _}) = name

  fun formals({name = _, formals = formals , frameSize = _}) = formals

  fun allocLocal fr esc = 
    let 
      fun incrementOffset {name=_, formals=_, frameSize = offset} = offset := !offset + wordSize
      fun getOffset       {name=_, formals=_, frameSize = offset} = !offset
    in 
      if esc
      then (incrementOffset fr; InFrame(-(getOffset frame)))
      else InReg(Temp.newtemp())
    end

  fun exp (InReg t) exp = Tree.TEMP(t)
    | exp (InFrame offset) exp = Tree.MEM(Tree.BINOP(Tree.PLUS, exp, T.CONST(offset)))
  
  fun procEntryExit1 (frame, stm) = stm (* to be implemented in a later phase *)

  fun externalCall (s,args) = T.CALL(T.NAME(Temp.namedlabel s), args)

  val wordSize = 4

  val FP = Temp.newtemp()
  val RV = Temp.newtemp()

  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string

  (* TODO *)
  fun string (label, str) = S.name label ^ str

end