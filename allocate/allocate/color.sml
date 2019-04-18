structure Color : COLOR = 
struct
	structure Frame = MipsFrame
	type allocation = Frame.register Temp.Map.map

	structure NodeSet = Temp.Set
	structure MoveSet = BinarySetFn(Liveness.EdgeOrd)

	structure RegisterSet = BinarySetFn(
		struct
	    type ord_key = Frame.register
	    val compare = String.compare
		end
	)

	structure Graph = Liveness.Graph
  type graph = unit Graph.graph

  datatype todo = Simplify of {remaining: Liveness.igraph, removed: Temp.temp, neighbors: Temp.temp list}
                | Coalesce of {remaining: Liveness.igraph, removed: Temp.temp, union: Temp.temp}
                | Unfreeze of {remaining: Liveness.igraph}
                | Spill of {remaining: Liveness.igraph, spilled: Temp.temp, neighbors: Temp.temp list}

	val inf = 10000000

  fun doIfNone(opt: 'a option, f: unit -> 'a option): 'a option = if isSome opt then opt else f()

	fun color({interference: Liveness.igraph,
							initial: allocation,
							spillCost: Temp.temp -> int,
							registers: Frame.register list}): allocation * Temp.temp list = 
		let 
      fun todoList(interference: Liveness.igraph): todo list = 
        let 
			    val Liveness.IGRAPH{graph=igraph, moves=moves} = interference

			    fun degree(v: Temp.temp): int = 
			    	case Temp.Map.find(initial, v) of
			    		SOME(r) => inf
			      | NONE => Graph.degree (Graph.getNode(igraph, v))

          fun simplify(Liveness.IGRAPH{graph=igraph, moves=moves}): todo option = NONE
          fun coalesce(Liveness.IGRAPH{graph=igraph, moves=moves}): todo option = NONE
          fun unfreeze(Liveness.IGRAPH{graph=igraph, moves=moves}): todo option = NONE
          fun spill(Liveness.IGRAPH{graph=igraph, moves=moves}): todo option = NONE

          val res = 
            doIfNone(simplify interference, fn () => 
            doIfNone(coalesce interference, fn () => 
            doIfNone(unfreeze interference, fn () => 
                     spill interference)))
        in
          case res of 
            SOME(Simplify{remaining, removed, neighbors}) => (valOf res) :: (todoList (remaining))
          | SOME(Coalesce{remaining, removed, union}) => (valOf res) :: (todoList (remaining))
          | SOME(Unfreeze{remaining}) => (valOf res) :: (todoList (remaining))
          | SOME(Spill{remaining, spilled, neighbors}) => (valOf res) :: (todoList (remaining))
          | NONE => []
        end
		in 
			(Temp.Map.empty, [])
		end
end
