signature LIVENESS =
sig
	structure Graph = FuncGraph sharing type nodeID = Temp.temp
	datatype igraph = IGRAPH of {graph: unit Graph.graph, moves: EdgeSet.set}
	val interferenceGraph: Flow.flowgraph -> igraph * (Flow.Graph.node -> Temp.temp list)
end
