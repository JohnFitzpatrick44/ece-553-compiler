structure MipsFrame :> FRAME = 
struct

  (* has a name, list of formals, and sp offset (ref int or no?) *)
  type frame = {name: Temp.label, formals: access list, frameOffset: int ref}

  datatype access = InFrame of int
                  | InReg of Temp.temp

  (* number of argument registers *)
  val aRegs = 4

  val frags : frag list ref = ref [] 

  fun newFrame({name = name, formals = formals}) = 
    let 

      (* Creates list of arguments as accesses. If argument registers remain, allocate to those *)
      fun allocFormals([], offset, unescaped) = []
        | allocFormals(escape::elist, offset, unescaped) = 
            let
              val totalOffset = ref 0
            in
              if ((not escape) andalso (unescaped < aRegs))
              then InReg(Temp.newtemp())::allocFormals(elist, offset, unescaped + 1)
              else (totalOffset := !totalOffset - wordSize; InFrame(offset - wordSize)::allocFormals(elist, offset - wordSize, unescaped))
            end
    in
      {name = name, formals = allocFormals(formals, 0, 0), totalOffset}
    end

  fun name({name = name, formals = _ , frameOffset = _}) = name
  fun formals({name = _, formals = formals , frameOffset = _}) = formals

  fun allocLocal fr esc = 
    let 
      fun decrementOffset {name=_, formals=_, frameOffset = offset} = offset := !offset - wordSize
      fun getOffset       {name=_, formals=_, frameOffset = offset} = !offset
    in 
      if esc
      then (decrementOffset fr; InFrame(getOffset frame))
      else InReg(Temp.newtemp())
    end

  fun exp(InReg t) exp = Tree.TEMP(t)
    | exp(InFrame offset) exp = Tree.MEM(Tree.BINOP(Tree.PLUS, exp, T.CONST(offset)))
  
  fun externalCall (s,args) = T.CALL(T.NAME(Temp.namedlabel s), args)

  fun procEntryExit1 (frame, stm) = stm

  val FP = Temp.newtemp()
  val RV = Temp.newtemp()
  val RA = Temp.newtemp()

  val wordSize = 4

  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string

  fun addFrag f = frags := (f :: !frags)
  fun getResult () = !frags
  fun clearFrags () = (frags := [])

end