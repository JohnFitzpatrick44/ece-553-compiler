structure RegAlloc : REGALLOC = 
struct
	structure Frame = MipsFrame

	type allocation = Frame.register Temp.Map.map

	structure Graph = Liveness.Graph

	(* val alloc : Assem.instr list * Frame.frame -> Assem.instr list * allocation *)
	fun alloc (instrs, frame) = 
		let
			(* liveouts: Flow.Graph.node -> Temp.temp list // To be honest, I don't know where I should use this, but the book said so lol *)
			val (igraph, liveouts) = Liveness.interferenceGraph(MakeGraph.instrs2graph instrs)


			fun count(elm, x :: rst) = if elm = x then 1 + count(elm, rst) else count(elm, rst)
				| count(elm, nil) = 0
			fun sum(x :: rst) = x + sum(rst)
				| sum(nil) = 0
			fun divAsReal(i1, i2) = (real i1) / (real i2)

			(* Simple heuristic for a node in the interference graph - (uses+defs)/degree *)
			fun spillCost(n): real = 
				let
					val t = Graph.getNodeID n
					fun countDefUse(Assem.OPER{assem=_, dst=dst, src=src, jump=_})= count(t, dst) + count(t, src)
						| countDefUse(Assem.LABEL{assem=_, lab=_}) = 0
						| countDefUse(Assem.MOVE{assem=_, dst=dst, src=src}) = count(t, [dst]) + count(t, [src])
				in
					divAsReal(sum (map countDefUse instrs), length (Graph.adj n))
				end

			(* sending the spillClost function directly is expensive, but I'm just gonna do it for simplicity *)

			fun getNode(t) = let val Liveness.IGRAPH{graph=g, moves=_} = igraph in Graph.getNode(g, t) end

			val (allocated, spills) = Color.color({interference = igraph,
					                                   initial = Frame.tempMap,
					                                   spillCost = spillCost o getNode,
                                             registers = Frame.registers})
		in
			if List.length spills = 0
			then (instrs, allocated)
			else ErrorMsg.impossible ((Int.toString (List.length spills)) ^ " spills occurred.")
		end

end
