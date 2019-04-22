signature LIVENESS =
sig
	datatype igraph = IGRAPH of {graph: unit Graph.graph, moves: EdgeSet.set}
	val interferenceGraph: Flow.flowgraph -> igraph * (Flow.Graph.node -> Temp.temp list)
end
