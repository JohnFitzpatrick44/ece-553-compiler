structure MipsGen : CODEGEN =
struct
	structure Frame = MipsFrame
	structure A = Assem
	structure T = Tree

	fun tempStr temp = Temp.makestring temp
	fun labStr lab = Temp.labelString lab
	fun iToS i = 
		if i < 0
		then "-" ^ Int.toString (0-i)
		else Int.toString i

	fun oper(assem, dst, src, jump) = A.OPER{assem=assem ^ "\n", dst=dst, src=src, jump=jump}
	fun label(assem, lab) = A.LABEL{assem=assem ^ "\n", lab=lab}
	fun move(assem, dst, src) = A.MOVE{assem=assem ^ "\n", dst=dst, src=src}

	fun codegen frame stm = 
		let 
			val ilist = ref (nil : A.instr list)
			fun emit x = ilist := x :: !ilist
			fun result(gen) = let val t = Temp.newtemp() in gen t; t end
			fun withTemp(gen) = let val t = Temp.newtemp() in gen t end
			val toDoTemp = Temp.newtemp()

			(* we can take care of > 4 args later... or do we even ?? *)
			fun munchArgs(idx, []) = []
			  | munchArgs(idx, arg::args) = (*(munchExp arg) :: (munchArgs (idx+1, args))*)
					if idx < (List.length Frame.argregs)
					then 
						let
							val src = munchExp arg
							val dst = (List.nth (Frame.argregs, i))
							val moveStm = T.MOVE(T.TEMP dst, T.TEMP src)
						in
							munchStm(moveStm);
                  			dst::munchArgs(idx+1,args)
						end
					else
						[] (*???*)

			and munchStm (T.SEQ(a, b)) = (munchStm(a); munchStm(b))

				(* MOVES *)
				(* Between regs *)
				| munchStm(T.MOVE(T.TEMP t, T.CONST c)) = emit(oper("li `d0, " ^ iToS c, [t], [], NONE))

				| munchStm(T.MOVE(T.TEMP t, T.CALL(T.NAME(lab), args))) = 
						(emit(oper("jal `j0", [Frame.RV], munchArgs(0, args), SOME [lab]));
						 emit(move("move `d0, `s0", t, Frame.RV)))

				| munchStm(T.MOVE(T.TEMP t, e)) = emit(move("move `d0, `s0", t, munchExp e))

				| munchStm(T.MOVE(T.MEM(T.TEMP t), T.BINOP(T.PLUS, e1, T.CONST c))) = 
						emit(oper("sw `s0, " ^ iToS c ^ "(`s1)", [], [munchExp e1, t], NONE))
				| munchStm(T.MOVE(T.MEM(T.TEMP t), T.BINOP(T.PLUS, T.CONST c, e1))) = 
						emit(oper("sw `s0, " ^ iToS c ^ "(`s1)", [], [munchExp e1, t], NONE))
				| munchStm(T.MOVE(T.MEM(T.TEMP t), T.BINOP(T.MINUS, e1, T.CONST c))) = 
						emit(oper("sw `s0, " ^ iToS (0-c) ^ "(`s1)", [], [munchExp e1, t], NONE))
				| munchStm(T.MOVE(T.MEM(T.TEMP t), exp)) = 
						emit(oper("sw `s0, 0(`s1)", [], [munchExp exp, t], NONE))
				| munchStm(T.MOVE(T.MEM(addrExp), exp)) = 
						emit(oper("sw `s0, 0(`s1)", [], [munchExp exp, munchExp addrExp], NONE))

				| munchStm(T.CJUMP(T.LT, T.CONST c1, T.CONST c2, t, f)) = 
						withTemp(fn r => 
							(emit(oper("li `d0, " ^ iToS (c1-c2), [r], [], NONE));
							 emit(oper("bltz `s0, `j0", [], [r], SOME [t]))))
				| munchStm(T.CJUMP(T.LT, e1, e2, t, f)) = 
						withTemp(fn r => 
							(emit(oper("subi `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE));
							 emit(oper("bltz `s0, `j0", [], [r], SOME [t]))))

				| munchStm(T.CJUMP(T.LE, T.CONST c1, T.CONST c2, t, f)) = 
						withTemp(fn r => 
							(emit(oper("li `d0, " ^ iToS (c1-c2), [r], [], NONE));
							 emit(oper("blez `s0, `j0", [], [r], SOME [t]))))
				| munchStm(T.CJUMP(T.LE, e1, e2, t, f)) = 
						withTemp(fn r => 
							(emit(oper("subi `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE));
							 emit(oper("blez `s0, `j0", [], [r], SOME [t]))))

				| munchStm(T.CJUMP(T.GE, T.CONST c1, T.CONST c2, t, f)) = 
						withTemp(fn r => 
							(emit(oper("li `d0, " ^ iToS (c1-c2), [r], [], NONE));
							 emit(oper("bgez `s0, `j0", [], [r], SOME [t]))))
				| munchStm(T.CJUMP(T.GE, e1, e2, t, f)) = 
						withTemp(fn r => 
							(emit(oper("subi `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE));
							 emit(oper("bgez `s0, `j0", [], [r], SOME [t]))))

				| munchStm(T.CJUMP(T.GT, T.CONST c1, T.CONST c2, t, f)) = 
						withTemp(fn r => 
							(emit(oper("li `d0, " ^ iToS (c1-c2), [r], [], NONE));
							 emit(oper("bgtz `s0, `j0", [], [r], SOME [t]))))
				| munchStm(T.CJUMP(T.GT, e1, e2, t, f)) = 
						withTemp(fn r => 
							(emit(oper("subi `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE));
							 emit(oper("bgtz `s0, `j0", [], [r], SOME [t]))))

				| munchStm(T.CJUMP(T.EQ, T.CONST c1, T.CONST c2, t, f)) = 
						withTemp(fn r => 
								if c1 = c2 then emit(oper("j `j0", [], [], SOME [t])) else ())
				| munchStm(T.CJUMP(T.EQ, e1, e2, t, f)) = 
						withTemp(fn r => 
							 emit(oper("beq `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t])))

				| munchStm(T.CJUMP(T.NE, T.CONST c1, T.CONST c2, t, f)) = 
						withTemp(fn r => 
								if c1 <> c2 then emit(oper("j `j0", [], [], SOME [t])) else ())
				| munchStm(T.CJUMP(T.NE, e1, e2, t, f)) = 
						withTemp(fn r => 
							 emit(oper("bne `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t])))

				| munchStm(T.JUMP(T.NAME(lab), labs)) = emit(oper("j `j0", [], [], SOME(labs)))
				| munchStm(T.LABEL(lab)) = emit(label(labStr lab ^ ":\n", lab))

			and	munchExp(T.BINOP(T.PLUS, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0, " ^ iToS (c1+c2), [r], [], NONE)))
			  |	munchExp(T.BINOP(T.PLUS, e1, T.CONST c)) = 
						result(fn r => emit(oper("addi `d0, `s0, " ^ iToS c, [r], [munchExp e1], NONE)))
			  |	munchExp(T.BINOP(T.PLUS, T.CONST c, e1)) = 
						result(fn r => emit(oper("addi `d0, `s0, " ^ iToS c, [r], [munchExp e1], NONE)))
				|	munchExp(T.BINOP(T.PLUS, e1, e2)) = 
						result(fn r => emit(oper("add `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE)))

				| munchExp(T.BINOP(T.MINUS, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0, " ^ iToS(c1-c2), [r], [], NONE)))
			  |	munchExp(T.BINOP(T.MINUS, e1, T.CONST c)) = 
						result(fn r => emit(oper("addi `d0, `s0, -" ^ iToS c, [r], [munchExp e1], NONE)))
			  |	munchExp(T.BINOP(T.MINUS, e1, e2)) = 
						result(fn r => emit(oper("sub `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE)))

				| munchExp(T.BINOP(T.MUL, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0, " ^ iToS(c1*c2), [r], [], NONE)))
				| munchExp(T.BINOP(T.MUL, e1, e2)) = 
						result(fn r => (emit(oper("mult `s0, `s1", [], [munchExp e1, munchExp e2], NONE));
														emit(oper("mflo `d0", [r], [], NONE))))
				| munchExp(T.BINOP(T.DIV, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0, " ^ iToS(c1 div c2), [r], [], NONE)))
				| munchExp(T.BINOP(T.DIV, e1, e2)) = 
						result(fn r => (emit(oper("div `s0, `s1", [], [munchExp e1, munchExp e2], NONE));
														emit(oper("mflo `d0", [r], [], NONE))))

				| munchExp(T.CONST c) = result(fn r => emit(oper("li `d0, " ^ iToS c, [r], [], NONE)))

				| munchExp(T.MEM(T.BINOP(T.PLUS, T.TEMP t, T.CONST c))) = 
						result(fn r => emit(oper("lw `d0, " ^ iToS c ^ "(`s0)", [r], [t], NONE)))
				| munchExp(T.MEM(T.BINOP(T.PLUS, T.CONST c, T.TEMP t))) = 
						result(fn r => emit(oper("lw `d0, " ^ iToS c ^ "(`s0)", [r], [t], NONE)))
				| munchExp(T.MEM(T.BINOP(T.MINUS, T.TEMP t, T.CONST c))) = 
						result(fn r => emit(oper("lw `d0, " ^ iToS (0-c) ^ "(`s0)", [r], [t], NONE)))
				| munchExp(T.MEM e) = 
						result(fn r => emit(oper("lw `d0, 0(`s0)", [r], [munchExp e], NONE)))

				| munchExp(T.TEMP t) = t
				| munchExp(exp) = toDoTemp

		in munchStm stm;
			 rev(!ilist)
		end
end
