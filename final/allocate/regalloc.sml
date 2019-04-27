structure RegAlloc : REGALLOC = 
struct
	structure Frame = MipsFrame

	type allocation = Frame.register Temp.Map.map

	structure Graph = Liveness.Graph

	(* val alloc : Assem.instr list * Frame.frame -> Assem.instr list * allocation *)
	fun alloc (instrs', frame) = 
		let
			val {prolog=prolog, body=body, epilog=epilog} = Frame.procEntryExit3(frame, instrs')
			val instrs = prolog @ body @ epilog

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
                                             registers = Frame.nonZeroRegisters})

			fun rebuildFromSpill(instrs, spills) = 
				let 
					val _ = print ("rebuilding with " ^ (Int.toString (length spills)) ^ " spills: " ^ (String.concatWith ", " (map Temp.makestring spills)) ^ "\n")
					fun augmentInstr(spill, instrs) = 
						let
							val access = Frame.allocLocal frame true (* true so that we get InFrame *)

							fun genFetch t = Assem.OPER{assem = Frame.fetchInstr access, dst=[t], src=[Frame.FP], jump=NONE}
							fun genStore t = Assem.OPER{assem = Frame.storeInstr access, dst=[], src=[t, Frame.FP], jump=NONE}

							fun replace(t, x::rst) = if x = spill then t :: rst else x :: replace(t, rst)
								| replace(t, []) = []
							fun hasSpill(x::rst) = x = spill orelse hasSpill rst
								| hasSpill([]) = false

							fun addInstrs(instr, acc) = 
								case instr of
									Assem.OPER{assem, dst, src, jump} => 
										(case (hasSpill dst, hasSpill src) of
											(true, true) => 
										    let 
													val t = Temp.newtemp()
													val d = Temp.newtemp()
										    in (genFetch t) :: Assem.OPER{assem=assem, dst=replace(d, dst), src=replace(t, src), jump=jump} :: (genStore d) :: acc end	
										| (true, false) => 	
										    let val t = Temp.newtemp()
										    in Assem.OPER{assem=assem, dst=replace(t, dst), src=src, jump=jump} :: (genStore t) :: acc end	
										| (false, true) => 
										    let val t = Temp.newtemp()
										    in (genFetch t) :: Assem.OPER{assem=assem, dst=dst, src=replace(t, src), jump=jump} :: acc end	
										| (false, false) => Assem.OPER{assem=assem, dst=dst, src=src, jump=jump} :: acc)

								|	Assem.LABEL{assem, lab} => instr :: acc
								|	Assem.MOVE{assem, dst, src} => 
										(case (hasSpill [dst], hasSpill [src]) of
											(true, true) => 
										    let 
													val t = Temp.newtemp()
													val d = Temp.newtemp()
										    in (genFetch t) :: Assem.MOVE{assem=assem, dst=hd (replace(d, [dst])), src=hd (replace(t, [src]))} :: (genStore d) :: acc end	
										| (true, false) => 	
										    let val t = Temp.newtemp()
										    in Assem.MOVE{assem=assem, dst=hd (replace(t, [dst])), src=src} :: (genStore t) :: acc end	
										| (false, true) => 
										    let val t = Temp.newtemp()
										    in (genFetch t) :: Assem.MOVE{assem=assem, dst=dst, src=hd (replace(t, [src]))} :: acc end	
										| (false, false) => Assem.MOVE{assem=assem, dst=dst, src=src} :: acc)
						in
							foldr addInstrs [] instrs
						end
				in
					foldl augmentInstr instrs spills
				end
		in
			if List.length spills = 0
			then (instrs, allocated)
			else alloc(rebuildFromSpill(body, spills), frame)
		end

end
