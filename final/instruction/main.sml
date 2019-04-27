structure Main = struct

structure F = MipsFrame
structure Tr = Translate(F)
structure S = Semant(Tr)
(*structure R = RegAlloc*)

fun getsome (SOME x) = x

fun emitproc out (F.PROC{body,frame}) =
  let 
    fun tempString alloc temp = case Temp.Map.find(alloc, temp) of
                                  SOME(r) => r
                                | NONE => Temp.makestring temp 
		val _ = print ("emit " ^ Temp.labelString (F.name frame) ^ "\n")
	  val stms = Canon.linearize body
    val stms' = Canon.traceSchedule(Canon.basicBlocks stms)

    val _ = app (fn s => Printtree.printtree(TextIO.stdOut, s)) stms'

	  val instrs = List.concat(map (MipsGen.codegen frame) stms') 
    val (finalInstr, alloc) = RegAlloc.alloc(instrs, frame)

		val _ = print "------------------- Original -------------------\n"
    val format0 = Assem.format(Temp.makestring) 
		val _ = app (fn i => print(format0 i)) instrs
		val _ = print "---------------- End Original -------------------\n"
		val _ = print "---------------- Reconstructed -------------------\n"
    val format0 = Assem.format(Temp.makestring) 
		val _ = app (fn i => print(format0 i)) finalInstr

		val _ = print "---------------- End Reconstructed -------------------\n"

    val format0 = Assem.format(tempString alloc) 
		val _ = app (fn i => TextIO.output(out, format0 i)) finalInstr
  in 
		()
  end

| emitproc out (F.STRING(lab,s)) = TextIO.output(out,F.string(lab,s))

  fun withOpenFile fname f = 
      let val out = TextIO.openOut fname
       in (f out before TextIO.closeOut out) 
	   handle e => (TextIO.closeOut out; raise e)
      end 

  fun compile filename = 
      let val _ = Tr.clear() 
	        val absyn = Parse.parse filename
          (* val () = PrintAbsyn.print(TextIO.stdOut, absyn) *)
          val frags = (FindEscape.prog absyn; S.transProg absyn) (* if err is 1, then abort *)
          fun separateStrings frag = case frag of 
                                       F.STRING(_) => true
                                     | _ => false
          val (strings, instrs) = List.partition separateStrings frags
        in 
          withOpenFile (filename ^ ".s") (fn out => (
            TextIO.output(out,".globl main\n.data\n");
            app (emitproc out) strings;
            TextIO.output(out,".text\n");
            app (emitproc out) instrs;
            TextIO.output(out, TextIO.inputAll (TextIO.openIn "runtime.s"))
          ))
      end
	
	fun test filename = 
      let val _ = Tr.clear() 
					val absyn = Parse.parse filename
          val frags = (FindEscape.prog absyn; S.transProg absyn)
       in	 
           app (emitproc TextIO.stdOut) frags
      end
end



