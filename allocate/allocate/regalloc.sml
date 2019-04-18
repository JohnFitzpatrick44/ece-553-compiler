structure RegAlloc : REGALLOC = 
struct
	structure Frame = MipsFrame

	type allocation = Frame.register Temp.Map.map

	(* val alloc : Assem.instr list * Frame.frame -> Assem.instr list * allocation *)
	fun alloc (instrs, frame) = 
		let
			(* liveouts: Flow.Graph.node -> Temp.temp list // To be honest, I don't know where I should use this, but the book said so lol *)
			val (igraph, liveouts) = Liveness.interferenceGraph(MakeGraph.instrs2graph instrs)

			val (allocated, spills) = Color.color({interference = igraph,
					                                   initial = Frame.tempMap,
					                                   spillCost = (fn _ => 1), (* Implement with spills *)
                                             registers = Frame.registers})
		in
			if List.length spills = 0
			then (instrs, allocated)
			else ErrorMsg.impossible ((Int.toString (List.length spills)) ^ " spills occurred.")
		end

end
