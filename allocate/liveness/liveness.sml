structure Liveness = 
struct

structure Graph = FuncGraph(Temp.TempOrd)

structure EdgeOrd = 
struct
	type ord_key = Graph.nodeID * Graph.nodeID
	fun compare((a1, a2), (b1, b2)) = 
	  case (Graph.cmpID(a1, b1), Graph.cmpID(a2, b2)) of
	  	(EQUAL, EQUAL) => EQUAL
	  | (EQUAL, ord) => ord
	  | (ord, _) => ord
end
				
structure EdgeSet = BinarySetFn(EdgeOrd)
fun addMoveEdge(s, (id1, id2)) = EdgeSet.addList(s, [(id1, id2), (id2, id1)])

datatype igraph = IGRAPH of {graph: unit Graph.graph, moves: EdgeSet.set}
structure FGraph = Flow.Graph
structure LMap = BinaryMapFn(Flow.NodeOrd)
structure LSet = BinarySetFn(Temp.TempOrd)

fun flatmap f lst = foldl (fn (a, acc) => f(a) @ acc) [] lst
fun cartesian lst1 lst2 = flatmap (fn e => map (fn e2 => (e, e2)) lst2) lst1
fun nodeID node = FGraph.getNodeID node
fun fromList lst = LSet.addList(LSet.empty, lst)

fun formatNode (nid, ()) = Temp.makestring nid
fun printGraph(IGRAPH{graph, moves}) = Graph.printGraph formatNode Temp.makestring graph
fun printNeighbors(IGRAPH{graph, moves}, t) = 
	let
		val _ = print ("------" ^ Temp.makestring t ^ "'s Neighbors-----\n")
		val _ = print (String.concatWith ", " (map Temp.makestring (Graph.adj (Graph.getNode(graph, t)))))
		val _ = print "\n"
	in
		()
	end



(* Flow.flowgraph -> igraph * (Flow.Graph.node -> Temp.temp list) <--- Didn't include yet; Why do we even need this? *)
fun interferenceGraph(flowgraph) =
	let 
		val flowNodes = FGraph.nodes flowgraph
		val flowKeys = map nodeID flowNodes
		val temps = foldl (fn (n, acc) => (Flow.defs n) @ (Flow.uses n) @ acc) [] flowNodes
		val emptyLiveinfo = foldl (fn (n, map) => LMap.insert(map, n, (LSet.empty, LSet.empty))) LMap.empty flowKeys
		val unconnected = foldl (fn (t, g) => Graph.addNode(g, t, ())) Graph.empty temps

		(* checks if live in/out didn't change *)
		fun noChange(prev, cur): bool = 
			LMap.foldli (fn (k, (in1, out1), verdict) => 
										case LMap.find(prev, k) of
											SOME(in2, out2) => verdict andalso LSet.equal(in1,in2) andalso LSet.equal(out1, out2)
										| NONE => ErrorMsg.impossible "interferenceGraph(): initial map wrongly populated") 
									true cur

		(* iteratively updates live in/out *)
		fun step(liveinfo) = 
			let 
				fun liveIn(n, info) = let val SOME(livein, _) = LMap.find(info, nodeID n) in livein end
				fun liveOut(n, info) = let val SOME(_, liveout) = LMap.find(info, nodeID n) in liveout end

				fun updateInfo(n, info) = 
					let 
						val nid = nodeID n
						val SOME(previn, prevout) = LMap.find(info, nid)
						val newout = FGraph.foldSuccs' flowgraph (fn (succ, s) => LSet.union(s, liveIn(succ, info))) prevout n
						val newin = LSet.union(LSet.difference(newout, fromList (Flow.defs n)), fromList (Flow.uses n))
					in
						LMap.insert(info, nid, (newin, newout))
					end

				val newLiveinfo = FGraph.foldNodes updateInfo liveinfo flowgraph
			in
			  if noChange(liveinfo, newLiveinfo) then liveinfo else step newLiveinfo 
			end

		(* Complete Map from (flow node) to (Set of live in, Set of live out) *)
		val liveinfo = step emptyLiveinfo
		
		(* given a defined temp and a set of live temps, returns a list of interferences *)
		fun interferences(t, SOME(_, out)) = map (fn t' => (t, t')) (LSet.listItems out)
			| interferences(t, NONE) = []

		(* From a flow node, add double edges to interference graph and log moves *)
		fun addEdges(n, IGRAPH{graph=g, moves=s}) = 
			let 
				val nid = nodeID n
				val interfs = flatmap (fn d => interferences(d, LMap.find(liveinfo, nid))) (Flow.defs n)
				(* but if the instruction is a move, remove the (def, use) interferences *)
				val toRemove = cartesian (Flow.defs n) (Flow.uses n) (* (temp * temp) list *)
				val processed = if Flow.ismove n 
												then List.filter (fn p => List.exists (fn r => p <> r) toRemove) interfs
												else interfs
				(* and add it to moves *)
				val newMoves = if Flow.ismove n
											 then EdgeSet.addList(s, toRemove)
											 else s

				val newGraph = foldl (fn ((t1, t2), g) => Graph.doubleEdge(g, t1, t2)) g processed
			in 
				IGRAPH{graph=newGraph, moves=newMoves}
			end

		val emptyIGraph = IGRAPH{graph=unconnected, moves=EdgeSet.empty}
		val finalIgraph = FGraph.foldNodes addEdges emptyIGraph flowgraph

		fun liveOuts n = 
			case LMap.find(liveinfo, nodeID n) of
				SOME(_, liveout) => liveout
			| NONE => ErrorMsg.impossible "InterferenceGraph(): Invalid flow node given"

		fun setStr s = "{" ^ (String.concatWith ", " (map Temp.makestring (LSet.listItems s))) ^ "}"
		val q = LMap.foldri (fn (k, (s1, s2), str) => "--------------Node: " ^ (Temp.labelString k) ^ "---------------------\n" ^ 
																									"Live In:  " ^ (setStr s1) ^ "\n" ^
																									"Live Out: " ^ (setStr s2) ^ "\n" ^ str) 
												"" liveinfo
		(* val _ = print q *)
		(* val _ = printGraph(finalIgraph) *)
	in
		(finalIgraph, liveOuts)
	end

end
