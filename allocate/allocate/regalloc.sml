signature RegAlloc : REGALLOC = 
struct
	structure Frame = MipsFrame

	type allocation = Frame.register Temp.Table.table

	(* val alloc : Assem.instr list * Frame.frame -> Assem.instr list * allocation *)
	fun alloc (instrs, frame) = 
		let
			val igraph = Liveness.interferenceGraph(MakeGraph.instrs2graph instrs)
			val (allocated, spills) = Color.color{interference = igraph,
					                                  initial = Frame.tempMap,
					                                  spillCost = (fn _ => 1), (* Implement with spills *)
                                            registers = Frame.registers}
		in
			if List.length spills = 0
			then (instrs, allocated)
			else ErrorMsg.impossible ((List.length spills) ^ " spills occurred.")
		end