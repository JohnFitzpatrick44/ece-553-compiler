signature FRAME = 
sig 
  type frame
  type access

  val newFrame : {name: Temp.label, formals: bool list} -> frame
  val name : frame -> Temp.label
  val formals : frame -> access list
  val allocLocal : frame -> bool -> access

  val exp : access -> Tree.exp -> Tree.exp
  val procEntryExit1 : frame * Tree.stm -> Tree.stm
  val externalCall: string * Tree.exp list -> Tree.exp

  val wordSize : int

  val FP : Temp.temp
  val RV : Temp.temp

  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string

  val accessToStr: access -> string
  val printFrag: TextIO.outstream * frag -> unit

  val string : Tree.label * string -> string

end
