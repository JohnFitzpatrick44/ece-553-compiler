structure MakeGraph : MAKEGRAPH = 
struct
	structure F = Flow
	structure G = F.Graph
	structure T = Temp
	structure A = Assem
	

	(* Temp labels are used as graph indexes, to be compatible with instruction labels.

	   First, a node is created for every (relevant) instruction.

		 Then, the instructions are iterated over again,
		 either consolidating nodes or producing edges.

		 This may not be the most efficient way to do things, 
		 but it makes logical sense to me. *)

	fun instrs2graph instrs =
		let 

			(* Processes single instructions: 
				 OPER of {assem: string, dst: temp list, src: temp list, jump: label list option}
         LABEL of {assem: string, lab: Temp.label}
         MOVE of {assem: string, dst: temp, src: temp}

         Node info: assem, def, use, isMove
         Labels at end are reverse order 
			*)
			fun processInstr (A.OPER {assem=assem, dst=dst, src=src, jump=jump}, (graph, labels))
						let 
							val l = T.newlabel()
							val g = G.addNode(graph, l, (assem, dst, src, false))
						in 
							(g, l::labels)
						end

				| processInstr (A.LABEL {assem=assem, lab=lab}, (graph, labels))
						let 
							val g = G.addNode(graph, lab, (assem, [], [], false))
						in
							(g, lab::labels)
						end

				| processInstr (A.MOVE {assem=assem, dst=dst, src=src}, (graph, labels))
						let
							val l = T.newlabel()
							val g = G.addNode(graph, l, (assem, [dst], [src], true))
						in
							(g, l::labels)
						end

			val (procGraph, procLabels) = foldl processInstr G.empty instrs
			val instrLabelPairs = ListPair.zip (instrs, List.rev procLabels)

			fun linkNodes ([], graph) = graph
				| linkNodes ([(i, l)], graph) = graph
				| linkNodes ([(i1, l1)::(i2, l2)::etc], graph) = 
						case i1 of
							Assem.OPER{ jump = SOME labs, ... } => 
								let
									fun makeEdge (lab, g) = G.addEdge(g, { from: l1, to: lab }) 
								in
									linkNodes((i2, l2)::etc, foldl makeEdge graph labs)
								end

       			| _ => linkNodes((i2, l2)::etc, G.addEdge(graph, { from: l1, to: l2 }))

      val linkedGraph = foldl linkNodes procGraph instrLabelPairs

      val _ = G.printGraph ( (lab, (assem, defs, uses, isMove)) => "Node: " ^ (T.labelString lab) ^ 
      																													   ",\n--assem: " ^ assem ^
      																													   ",\n--defs: " ^ 
      																													   			(foldl ((def, str) => str^" "^(T.makestring def)) "" defs)^
      																													   ",\n--uses: " ^
      																													   			(foldl ((use, str) => str^" "^(T.makestring use)) "" uses)^
      																													   ",\n--move: " ^ (Bool.toString isMove) ^ "\n"
      																													   			) linkedGraph


		in 
			linkedGraph
		end







end