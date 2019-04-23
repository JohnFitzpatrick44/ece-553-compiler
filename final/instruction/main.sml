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

	  val instrs = List.concat(map (MipsGen.codegen frame) stms') 
		val instrs' = F.procEntryExit2(frame, instrs)

		val {body=instrs'', prolog=prolog, epilog=epilog} = F.procEntryExit3(frame, instrs')

    val (finalInstr, alloc) = RegAlloc.alloc(instrs'', frame)
    val format0 = Assem.format(tempString alloc) 

		val _ = TextIO.output(out, prolog)
		val _ = app (fn i => TextIO.output(out, format0 i)) instrs''
		val _ = TextIO.output(out, epilog)
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
      let val absyn = Parse.parse filename
          val frags = (FindEscape.prog absyn; S.transProg absyn)
          fun separateStrings frag = case frag of 
                                       F.STRING(_) => true
                                     | _ => false
          val (strings, instrs) = List.partition separateStrings frags
        in 
          withOpenFile (filename ^ ".s") (fn out => 
            TextIO.output(out,".globl main\n.data\n");
            app (emitproc out) strings;
            TextIO.output(out,".text\n");
            app (emitproc out) instrs
          )
      end
	
	fun test filename = 
      let val _ = Tr.clear() 
					val absyn = Parse.parse filename
          val frags = (FindEscape.prog absyn; S.transProg absyn)
       in	 
           app (emitproc TextIO.stdOut) frags
      end
end



