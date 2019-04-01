structure MipsGen : CODEGEN =
struct
	structure Frame = MipsFrame
	structure A = Assem
	structure T = Tree

	fun tempStr temp = Temp.makestring temp
	fun labStr lab = Temp.labelString lab
	fun iToS i = Int.toString i

	fun oper(assem, dst, src, jump) = A.OPER{assem=assem ^ "\n", dst=dst, src=src, jump=jump}
	fun label(assem, lab) = A.LABEL{assem=assem ^ "\n", lab=lab}
	fun move(assem, dst, src) = A.MOVE{assem=assem ^ "\n", dst=dst, src=src}

	fun codegen frame stm = 
		let 
			val ilist = ref (nil : A.instr list)
			fun emit x = ilist := x :: !ilist
			fun result(gen) = let val t = Temp.newtemp() in gen t; t end
			val toDoTemp = Temp.newtemp()

			fun munchStm(T.MOVE(T.TEMP i, T.CONST c)) = emit(oper("li `d0 " ^ iToS c, [i], [], NONE))
				| munchStm(T.MOVE(T.TEMP i, e)) = emit(move("move `d0 `s0", i, munchExp e))
				| munchStm(T.JUMP(T.NAME(lab), labs)) = emit(oper("j `j0", [], [], SOME(labs)))
				| munchStm(T.LABEL(lab)) = emit(label(labStr lab, lab))

			and	munchExp(T.BINOP(T.PLUS, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0 " ^ iToS (c1+c2), [r], [], NONE)))
			  |	munchExp(T.BINOP(T.PLUS, e1, T.CONST c)) = 
						result(fn r => emit(oper("addi `d0 `s0 " ^ iToS c, [r], [munchExp e1], NONE)))
			  |	munchExp(T.BINOP(T.PLUS, T.CONST c, e1)) = 
						result(fn r => emit(oper("addi `d0 `s0 " ^ iToS c, [r], [munchExp e1], NONE)))
				|	munchExp(T.BINOP(T.PLUS, e1, e2)) = 
						result(fn r => emit(oper("add `d0 `s0 `s1", [r], [munchExp e1, munchExp e2], NONE)))

				| munchExp(T.BINOP(T.MINUS, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0 " ^ iToS(c1-c2), [r], [], NONE)))
			  |	munchExp(T.BINOP(T.MINUS, e1, T.CONST c)) = 
						result(fn r => emit(oper("addi `d0 `s0 -" ^ iToS c, [r], [munchExp e1], NONE)))
			  |	munchExp(T.BINOP(T.MINUS, e1, e2)) = 
						result(fn r => emit(oper("sub `d0 `s0 `s1", [r], [munchExp e1, munchExp e2], NONE)))

				| munchExp(T.BINOP(T.MUL, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0 " ^ iToS(c1*c2), [r], [], NONE)))
				| munchExp(T.BINOP(T.MUL, e1, e2)) = 
						result(fn r => emit(oper("mult `s0 `s1\n
																			mflo `d0", [r], [munchExp e1, munchExp e2], NONE))) 

				| munchExp(T.BINOP(T.DIV, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0 " ^ iToS(c1/c2), [r], [], NONE)))
				| munchExp(T.BINOP(T.DIV, e1, e2)) = 
						result(fn r => emit(oper("div `s0 `s1\n
																			mflo `d0", [r], [munchExp e1, munchExp e2], NONE)))

				| munchExp(T.CONST c) = result(fn r => emit(oper("li `d0 " ^ iToS c, [r], [], NONE)))
				| munchExp(T.TEMP t) = t
				| munchExp(exp) = toDoTemp

		in munchStm stm;
			 rev(!ilist)
		end
end
