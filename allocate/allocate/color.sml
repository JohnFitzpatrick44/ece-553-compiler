structure Color : COLOR = 
struct
	structure Frame = MipsFrame
	type allocation = Frame.register Temp.Table.table

	structure NodeSet = BinarySetFn(Temp.TempOrd)

	structure MoveSet = BinarySetFn(Liveness.EdgeOrd)

	structure RegisterSet = BinarySetFn(
	    type ord_key = Frame.register
	    val compare = String.compare)


	(* TODO: val color: {interference: Liveness.igraph,
							initial: allocation,
							spillCost: Graph.node -> int,
							registers: Frame.register list} -> 	allocation * Temp.temp list) *)



end