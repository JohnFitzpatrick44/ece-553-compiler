structure Flow =
struct
    (*datatype flowgraph = FGRAPH of {control: Graph.graph,
				    def: Temp.temp list Graph.Table.table,
				    use: Temp.temp list Graph.Table.table,
				    ismove: bool Graph.Table.table}*)

	structure NodeOrd = Temp.LabelOrd
  structure Graph = FuncGraph(NodeOrd)

  type flowgraph = (string * Temp.temp list * Temp.temp list * bool) Graph.graph

	fun instr(n) = let val (instr, _, _, _) = Graph.nodeInfo n in instr end
	fun defs(n) = let val (_, defs, _, _) = Graph.nodeInfo n in defs end
	fun uses(n) = let val (_, _, uses, _) = Graph.nodeInfo n in uses end
	fun ismove(n) = let val (_, _, _, ismove) = Graph.nodeInfo n in ismove end

  (* Note:  any "use" within the block is assumed to be BEFORE a "def" 
        of the same variable.  If there is a def(x) followed by use(x)
       in the same block, do not mention the use in this data structure,
       mention only the def.

     More generally:
       If there are any nonzero number of defs, mention def(x).
       If there are any nonzero number of uses BEFORE THE FIRST DEF,
           mention use(x).

     For any node in the graph,  
           Graph.Table.look(def,node) = SOME(def-list)
           Graph.Table.look(use,node) = SOME(use-list)
   *)

end
