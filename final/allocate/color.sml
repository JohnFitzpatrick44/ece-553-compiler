structure Color : COLOR = 
struct
  structure L = Liveness

	structure Frame = MipsFrame
	type allocation = Frame.register Temp.Map.map

	structure NodeSet = Temp.Set
	structure MoveSet = BinarySetFn(L.EdgeOrd)

	structure RegisterSet = BinarySetFn(
		struct
	    type ord_key = Frame.register
	    val compare = String.compare
		end
	)

	structure Graph = L.Graph
  type graph = unit Graph.graph

  datatype todo = Simplify of {remaining: L.igraph, removed: Temp.temp, neighbors: Temp.temp list}
                | Coalesce of {remaining: L.igraph, removed: Temp.temp, union: Temp.temp}
                | Unfreeze of {remaining: L.igraph}
                | Spill of {remaining: L.igraph, spilled: Temp.temp, neighbors: Temp.temp list}

  fun todo2str(Simplify{remaining, removed, neighbors}) = 
    "[Simplify] removed: " ^ Temp.makestring removed ^ " neighbors: " ^ (String.concatWith ", " (map Temp.makestring neighbors))
    | todo2str(Coalesce{remaining, removed, union}) = 
    "[Coalesce] merged " ^ Temp.makestring removed ^ " into " ^ Temp.makestring union
    | todo2str(Unfreeze{remaining}) = 
    "[Unfreeze]"
    | todo2str(Spill{remaining, spilled, neighbors}) = 
    "[Spill] spilled: " ^ Temp.makestring spilled ^ " neighbors: " ^ (String.concatWith ", " (map Temp.makestring neighbors))

	val inf = 10000000

  fun doIfNone(opt: 'a option, f: unit -> 'a option): 'a option = if isSome opt then opt else f()
  fun headOption(x :: lst) = SOME(x)
    | headOption(nil) = NONE

  fun safeDelete(s, toRemove) = if RegisterSet.member(s, toRemove) then RegisterSet.delete(s, toRemove) else s

	fun color({interference: L.igraph,
							initial: allocation,
							spillCost: Temp.temp -> real,
							registers: Frame.register list}): allocation * Temp.temp list = 
		let 
      val K = length registers
      val registerSet = RegisterSet.addList (RegisterSet.empty, registers)

      fun todoList(interference: L.igraph): todo list = 
        let 
			    val L.IGRAPH{graph=igraph, moves=moves} = interference

          fun isInitial(v: Temp.temp): bool = isSome (Temp.Map.find(initial, v))
          fun degree(t: Temp.temp): int = length(Graph.adj (Graph.getNode(igraph, t)))

          fun simplify(L.IGRAPH{graph=igraph, moves=moves}): todo option = 
            let
              val moveRelated = L.EdgeSet.foldl (fn ((t1, t2), acc) => Temp.Set.add(Temp.Set.add (acc, t1), t2)) Temp.Set.empty moves
              fun simplifiable(n) = not (isInitial (Graph.getNodeID n)) andalso 
                                    degree (Graph.getNodeID n) < K andalso 
                                    not (Temp.Set.member(moveRelated, Graph.getNodeID n))
              val target = List.find simplifiable (Graph.nodes igraph)
              fun makeSimplify(n) = Simplify{remaining = L.IGRAPH{graph=Graph.remove(igraph, n), moves = moves}, 
                                             removed = Graph.getNodeID n,
                                             neighbors = Graph.adj n}
            in
              Option.map makeSimplify target
            end

          (* for later *)
          fun coalesce(L.IGRAPH{graph=igraph, moves=moves}): todo option = NONE

          fun unfreeze(L.IGRAPH{graph=igraph, moves=moves}): todo option = 
            let
              val moveRelated = L.EdgeSet.foldl (fn ((t1, t2), acc) => Temp.Set.add(Temp.Set.add (acc, t1), t2)) Temp.Set.empty moves

              fun pickLowerDegree(cur, NONE) = if isInitial cur then NONE else SOME(cur)
                | pickLowerDegree(cur, SOME(v)) = if isInitial cur orelse degree cur > degree v then SOME(v) else SOME(cur)

              val lowestDegree = Temp.Set.foldl pickLowerDegree NONE moveRelated 

              fun removeAll toRemove = 
                L.EdgeSet.foldl (fn ((v1, v2), acc) => if v1 = toRemove orelse v2 = toRemove
                                                       then acc
                                                       else L.EdgeSet.add(acc, (v1, v2))) L.EdgeSet.empty moves
              
              val updatedMoves = Option.map removeAll lowestDegree 
            in
              Option.map (fn newMoves => Unfreeze{remaining = L.IGRAPH{graph=igraph, moves=newMoves}}) updatedMoves
            end


          fun spill(L.IGRAPH{graph=igraph, moves=moves}): todo option = 
            let 
              fun pickLowerCost(cur, NONE) = if isInitial (Graph.getNodeID cur) then NONE else SOME(cur)
                | pickLowerCost(cur, SOME(v)) = 
                    if isInitial (Graph.getNodeID cur) orelse spillCost (Graph.getNodeID cur) < spillCost (Graph.getNodeID v) 
                    then SOME(cur)
                    else SOME(v) 

              val highestDegree = foldl pickLowerCost NONE (Graph.nodes igraph)

              fun makeSpill toRemove = Spill{remaining=L.IGRAPH{graph=Graph.remove(igraph, toRemove), moves=moves},
                                             spilled=Graph.getNodeID toRemove,
                                             neighbors=Graph.adj toRemove}
            in
              Option.map makeSpill highestDegree
            end

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
      
      val todoStack = rev (todoList interference)

      (* prints out the stack *)
      fun println s = print (s ^ "\n")
      val () = app (println o todo2str) todoStack

      fun freeReg(neighbors, alloc): Frame.register option = 
        let
          fun removeUsed(neighbor, remaining) =
            case Temp.Map.find(alloc, neighbor) of 
              SOME(reg) => safeDelete(remaining, reg) 
            | NONE => RegisterSet.empty

          val remaining = foldl removeUsed registerSet neighbors
        in
          headOption (RegisterSet.listItems remaining)
        end

      fun allocate(stack, alloc, spills): allocation * Temp.temp list = 
        case stack of
          Simplify{remaining, removed, neighbors}::rst => 
            (case freeReg(neighbors, alloc) of
               SOME(reg) => allocate(rst, Temp.Map.insert(alloc, removed, reg), spills)
             | NONE => (print "Some neighbors were spilled... can't simplify\n" ; allocate(rst, alloc, spills)))

        | Coalesce{remaining, removed, union}::rst => 
            (case Temp.Map.find(alloc, union) of
               SOME(reg) => allocate(rst, Temp.Map.insert(alloc, removed, reg), spills)
             | NONE => (print "The union spilled... can't simplify\n" ; allocate(rst, alloc, spills)))

        | Unfreeze{remaining}::rst => allocate(rst, alloc, spills)

        | Spill{remaining, spilled, neighbors}::rst => 
            (case freeReg(neighbors, alloc) of
               SOME(reg) => allocate(rst, Temp.Map.insert(alloc, spilled, reg), spills) (* yay *)
             | NONE => allocate(rst, alloc, spilled :: spills))

        | nil => (alloc, spills)
		in 
			allocate(todoStack, initial, [])
		end
end
