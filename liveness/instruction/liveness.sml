structure Liveness:> LIVENESS
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

(* Flow.flowgraph -> igraph * (Flow.Graph.node -> Temp.temp list) <--- Why do we even need this? *)
fun interferenceGraph(flowgraph) =
	let val flowNodes = FGraph.nodes flowgraph
		val temps = foldl (fn (n, acc) => (Flow.defs n) @ (Flow.uses n) @ acc) [] flowNodes
		val emptyLiveinfo = foldl (fn (n, map) => LMap.insert(map, n, (LSet.empty, LSet.empty))) LMap.empty flowNodes
		val unconnected = foldl (fn (t, g) => Graph.addNode(g, t, ())) Graph.empty temps

		(* checks if live in/out changed *)
		fun didChange(prev, cur): bool = 
			LMap.foldli (fn (k, (in1, out1), verdict) => 
										case LMap.find(prev, k) in 
											SOME(in2, out2) => verdict orelse (not LSet.equal(in1,in2)) orelse (not LSet.equal(out1, out2))
										| NONE => false) false cur

		(* iteratively updates live in/out *)
		fun step(liveinfo) = 
			let 
				fun liveIn(n, info) = let val SOME(livein, _) = LMap.find(info, n) in livein end
				fun liveOut(n, info) = let val SOME(_, liveout) = LMap.find(info, n) in liveout end

				fun updateInfo(n, info) = 
					let 
						val SOME(previn, prevout) = LMap.find(info, n)
						val newout = FGraph.foldSuccs' flowgraph (fn (succ, s) => LSet.union(s, liveIn(succ, info))) prevout n
						val newin = LSet.union(LSet.difference(newout, Flow.defs n), Flow.uses n)
					in
						FMap.insert(info, n, (newin, newout))
					end

				val newLiveinfo = FGraph.foldNodes updateInfo liveinfo flowgraph
			in
			  if didChange(liveinfo, newLiveinfo) then step newLiveinfo else liveinfo
			end

		(* Completed Map from (flow node) to (Set of live in, Set of live out) *)
		val liveinfo = step emptyLiveinfo
		
		(* given a defined temp and a set of live temps, returns a list of interferences *)
		fun interferences(t, SOME(_, out)) = map (fn t' => (t, t')) (LSet.listItems out)
			| interferences(t, NONE) = []

		(* From a flow node, add double edges to interference graph and log moves *)
		fun addEdges(n, IGraph{graph: g, moves: s}) = 
			let 
				val interfs = flatmap (fn d => interferences(d, LMap.find(liveinfo, n))) (Flow.defs n)
				(* but if the instruction is a move, remove the (def, use) interferences *)
				val toRemove = cartesian (Flow.defs n) (Flow.uses n)
				val processed = if Flow.ismove n 
												then List.filter (fn p => List.exists (fn r => p = r) toRemove) interfs
												else interfs
			in 
				foldl (fn ((n1, n2), g) => Graph.doubleEdge(g, Graph.getNodeID n1, Graph.getNodeID n2)) g processed
			end
	in
		FGraph.foldNodes addEdges IGraph{graph: unconnected, moves: EdgeSet.empty} flowgraph
	end

end
