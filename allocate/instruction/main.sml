structure Main = struct

structure F = MipsFrame
structure Tr = Translate(F)
structure S = Semant(Tr)
(*structure R = RegAlloc*)

fun getsome (SOME x) = x

fun emitproc out (F.PROC{body,frame}) =
  let 
		val _ = print "---------------------------------\n"
		val _ = print ("emit " ^ Temp.labelString (F.name frame) ^ "\n")
		(* val _ = Printtree.printtree(out,body) *)
	  val stms = Canon.linearize body
    val stms' = Canon.traceSchedule(Canon.basicBlocks stms)

		(* val _ = print "-------------Linearized------------\n"
		val _ = app (fn s => Printtree.printtree(out,s)) stms' *)

	  val instrs = List.concat(map (MipsGen.codegen frame) stms') 
		val instrs' = F.procEntryExit2(frame, instrs)
		val {body=instrs'', prolog=prolog, epilog=epilog} = F.procEntryExit3(frame, instrs')


    (* val _ = print "-----------Instructions before allocation--------------\n"
    val format0 = Assem.format(Temp.makestring) (* Temp.makestring for now, we'll change it later on registor alloc *)
		val _ = TextIO.output(out, prolog)
		val _ = app (fn i => TextIO.output(out,format0 i)) instrs''
		val _ = TextIO.output(out, epilog) *)

    val _ = print "-----------Instructions after allocation--------------\n"
    val (finalInstr, alloc) = RegAlloc.alloc(instrs'', frame)

    val format1 = Assem.format(fn t => case Temp.Map.find(alloc, t) of SOME(reg) => reg | NONE => "SPILLLLL")
		val _ = TextIO.output(out, prolog)
		val _ = app (fn i => TextIO.output(out,format1 i)) finalInstr
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
       in 
           withOpenFile (filename ^ ".s") (fn out => (app (emitproc out) frags))
      end
	
	fun test filename = 
      let val _ = Tr.clear() 
					val absyn = Parse.parse filename
          val frags = (FindEscape.prog absyn; S.transProg absyn)
       in	 
           app (emitproc TextIO.stdOut) frags
      end
end



