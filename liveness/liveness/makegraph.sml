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

  	fun instrs2graph(instrsList) =
  		let 

  			(* Processes single instructions: 
					 OPER of {assem: string, dst: temp list, src: temp list, jump: label list option}
           LABEL of {assem: string, lab: Temp.label}
           MOVE of {assem: string, dst: temp, src: temp}
  			*)
  			fun processInstr (A.OPER {assem=assem, dst=dst, src=src, jump=jump}, graph, labels)
  						let 
  							val l = T.newLabel()
  							val g = G.addNode'(g, l, nodeInfo)
  						in 

  						end

  				| processInstr (A.LABEL {assem=assem, lab=lab}, graph, labels)

  				| processInstr (A.MOVE {assem=assem, dst=dst, src=src}, graph, labels)


  			fun consolidateInstr (A.OPER {assem=assem, dst=dst, src=src, jump=jump}, graph, labels)

  				| consolidateInstr (A.LABEL {assem=assem, lab=lab}, graph, labels)

  				| consolidateInstr (A.MOVE {assem=assem, dst=dst, src=src}, graph, labels)
end