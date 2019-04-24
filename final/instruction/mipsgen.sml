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
	fun label(assem, lab) = A.LABEL{assem=assem, lab=lab}
	fun move(assem, dst, src) = A.MOVE{assem=assem ^ "\n", dst=dst, src=src}

	fun codegen frame stm = 
		let 
			val ilist = ref (nil : A.instr list)
			fun emit x = ilist := x :: !ilist
			fun result(gen) = let val t = Temp.newtemp() in gen t; t end
			val toDoTemp = Temp.newtemp()




			fun munchArgs(idx, []) = []
			  | munchArgs(idx, arg::args) = (*(munchExp arg) :: (munchArgs (idx+1, args))*)
			  	let
			  		val src = T.TEMP (munchExp arg)
			  		val dst = if idx < (List.length Frame.argregs) then
			  			(T.TEMP (List.nth (Frame.argregs, idx)))
			  		else
			  			T.MEM(T.BINOP(T.PLUS, T.TEMP Frame.SP, T.CONST( (idx-(List.length Frame.argregs))*Frame.wordSize )))
			  	in
			  		munchStm(T.MOVE(dst, src));
			  		case dst of
	            T.TEMP t => t::munchArgs(idx+1,args)
	          | _ => munchArgs(idx+1,args)
			  	end

			and munchStm (T.SEQ(a, b)) = (munchStm(a); munchStm(b))

				(* MOVES *)
				(* loads *)

				| munchStm (T.MOVE(T.TEMP t, T.CONST c)) = emit(oper("li `d0, " ^ iToS c, [t], [], NONE))

		        | munchStm (T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.PLUS, e, T.CONST c)))) =
		            	emit(oper("lw `d0, " ^ iToS c ^ "(`s0)", [t], [munchExp e], NONE))

		        | munchStm (T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.PLUS, T.CONST c, e)))) =
		            	emit(oper("lw `d0, " ^ iToS c ^ "(`s0)", [t], [munchExp e], NONE))

		        | munchStm (T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.MINUS, e, T.CONST c)))) =
		            	emit(oper("lw `d0, " ^ iToS (~c) ^ "(`s0)", [t], [munchExp e], NONE))


		        (* stores *)
				
		        | munchStm (T.MOVE(T.MEM(T.BINOP(T.PLUS, e1, T.CONST c)), e2)) =
            			emit(oper("sw `s0, " ^ iToS c ^ "(`s1)", [], [munchExp e2, munchExp e1], NONE))

	            | munchStm (T.MOVE(T.MEM(T.BINOP(T.PLUS, T.CONST c, e1)), e2)) =
	            		emit(oper("sw `s0, " ^ iToS c ^ "(`s1)", [], [munchExp e2, munchExp e1], NONE))

		        | munchStm (T.MOVE(T.MEM(T.BINOP(T.MINUS, e1, T.CONST c)), e2)) =
		        	    emit(oper("sw `s0, " ^ iToS (~c) ^ "(`s1)", [], [munchExp e2, munchExp e1], NONE))

          		| munchStm (T.MOVE(T.MEM(e1), e2)) =
			            emit(oper("sw `s0, 0(`s1)", [], [munchExp e2, munchExp e1], NONE))


			    (* general move *)

			    | munchStm (T.MOVE(T.TEMP t, e)) =
            			emit(move("move `d0, `s0", t, munchExp e))


            	(* procedure call ..? *)					


				(* conditionals *)
				(* comparing 0 *)

				| munchStm (T.CJUMP(T.GE, e, T.CONST 0, t, f)) = emit(oper("bgez `s0, `j0", [], [munchExp e], SOME [t, f]))
				| munchStm (T.CJUMP(T.GE, T.CONST 0, e, t, f)) = emit(oper("bltz `s0, `j0", [], [munchExp e], SOME [t, f]))

        | munchStm (T.CJUMP(T.GT, e, T.CONST 0, t, f)) = emit(oper("bgtz `s0, `j0", [], [munchExp e], SOME [t, f]))
        | munchStm (T.CJUMP(T.GT, T.CONST 0, e, t, f)) = emit(oper("blez `s0, `j0", [], [munchExp e], SOME [t, f]))

        | munchStm (T.CJUMP(T.LE, e, T.CONST 0, t, f)) = emit(oper("blez `s0, `j0", [], [munchExp e], SOME [t, f]))
        | munchStm (T.CJUMP(T.LE, T.CONST 0, e, t, f)) = emit(oper("bgtz `s0, `j0", [], [munchExp e], SOME [t, f]))

        | munchStm (T.CJUMP(T.LT, e, T.CONST 0, t, f)) = emit(oper("bltz `s0, `j0", [], [munchExp e], SOME [t, f]))
        | munchStm (T.CJUMP(T.LT, T.CONST 0, e, t, f)) = emit(oper("bgez `s0, `j0", [], [munchExp e], SOME [t, f]))

        | munchStm (T.CJUMP(T.EQ, e, T.CONST 0, t, f)) = emit(oper("beqz `s0, `j0", [], [munchExp e], SOME [t, f]))
        | munchStm (T.CJUMP(T.EQ, T.CONST 0, e, t, f)) = emit(oper("beqz `s0, `j0", [], [munchExp e], SOME [t, f]))

        | munchStm (T.CJUMP(T.NE, e, T.CONST 0, t, f)) = emit(oper("bnez `s0, `j0", [], [munchExp e], SOME [t, f]))
        | munchStm (T.CJUMP(T.NE, T.CONST 0, e, t, f)) = emit(oper("bnez `s0, `j0", [], [munchExp e], SOME [t, f]))


        (* general conditional *)
				
				| munchStm(T.CJUMP(T.LT, e1, e2, t, f)) = emit(oper("blt `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.LE, e1, e2, t, f)) = emit(oper("ble `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.GT, e1, e2, t, f)) = emit(oper("bgt `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.GE, e1, e2, t, f)) = emit(oper("bge `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.ULT, e1, e2, t, f)) = emit(oper("bltu `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.ULE, e1, e2, t, f)) = emit(oper("bleu `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.UGT, e1, e2, t, f)) = emit(oper("bgtu `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.UGE, e1, e2, t, f)) = emit(oper("bgeu `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.EQ, e1, e2, t, f)) = emit(oper("beq `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.CJUMP(T.NE, e1, e2, t, f)) = emit(oper("bne `s0, `s1, `j0", [], [munchExp e1, munchExp e2], SOME [t, f]))

				| munchStm(T.JUMP(T.NAME(lab), labs)) = emit(oper("j `j0", [], [], SOME([lab])))

        | munchStm (T.JUMP(e, labs)) = emit(oper("jr `s0", [], [munchExp e], SOME labs))

				| munchStm(T.LABEL(lab)) = emit(label(labStr lab ^ ":\n", lab))

				| munchStm (T.EXP e) = (munchExp e; ())

				| munchStm _ = ErrorMsg.impossible "Could not munch statement"



			and	munchExp(T.BINOP(T.PLUS, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0, " ^ iToS (c1+c2), [r], [], NONE)))

			    | munchExp(T.BINOP(T.PLUS, e1, T.CONST c)) = 
						result(fn r => emit(oper("addi `d0, `s0, " ^ iToS c, [r], [munchExp e1], NONE)))
			    | munchExp(T.BINOP(T.PLUS, T.CONST c, e1)) = 
						result(fn r => emit(oper("addi `d0, `s0, " ^ iToS c, [r], [munchExp e1], NONE)))
				| munchExp(T.BINOP(T.PLUS, e1, e2)) = 
						result(fn r => emit(oper("add `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE)))

				| munchExp(T.BINOP(T.MINUS, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0, " ^ iToS(c1-c2), [r], [], NONE)))
			    | munchExp(T.BINOP(T.MINUS, e1, T.CONST c)) = 
						result(fn r => emit(oper("addi `d0, `s0, " ^ iToS (~c), [r], [munchExp e1], NONE)))
			    | munchExp(T.BINOP(T.MINUS, e1, e2)) = 
						result(fn r => emit(oper("sub `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE)))

				| munchExp(T.BINOP(T.MUL, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0, " ^ iToS(c1*c2), [r], [], NONE)))
				| munchExp(T.BINOP(T.MUL, e1, e2)) = 
						result(fn r => emit(oper("mult `s0, `s1\nmflo `d0", [r], [munchExp e1, munchExp e2], NONE)))

				| munchExp(T.BINOP(T.DIV, T.CONST c1, T.CONST c2)) = 
						result(fn r => emit(oper("li `d0, " ^ iToS(c1 div c2), [r], [], NONE)))
				| munchExp(T.BINOP(T.DIV, e1, e2)) = 
						result(fn r => emit(oper("div `s0, `s1\nmflo `d0", [r], [munchExp e1, munchExp e2], NONE)))

          		| munchExp (T.BINOP(T.AND, e, T.CONST c)) =
            			result(fn r => emit(oper("andi `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE)))
            	| munchExp (T.BINOP(T.AND, T.CONST c, e)) =
            			result(fn r => emit(oper("andi `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE)))
            	| munchExp (T.BINOP(T.AND, e1, e2)) =
            			result(fn r => emit(oper("and `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE)))

            	| munchExp (T.BINOP(T.OR, e, T.CONST c)) =
            			result(fn r => emit(oper("ori `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE)))
            	| munchExp (T.BINOP(T.OR, T.CONST c, e)) =
            			result(fn r => emit(oper("ori `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE)))
            	| munchExp (T.BINOP(T.OR, e1, e2)) =
            			result(fn r => emit(oper("or `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE)))

            	| munchExp (T.BINOP(T.XOR, e, T.CONST c)) =
            			result(fn r => emit(oper("xori `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE)))
            	| munchExp (T.BINOP(T.XOR, T.CONST c, e)) =
            			result(fn r => emit(oper("xori `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE)))
            	| munchExp (T.BINOP(T.XOR, e1, e2)) =
            			result(fn r => emit(oper("xor `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE)))

          		| munchExp (T.BINOP(T.LSHIFT, e, T.CONST c)) =
            			result (fn r => emit (oper("sll `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE))) 
            	| munchExp (T.BINOP(T.LSHIFT, e1, e2)) =
            			result (fn r => emit (oper("sllv `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE))) 

            	| munchExp (T.BINOP(T.RSHIFT, e, T.CONST c)) =
            			result (fn r => emit (oper("srl `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE))) 
            	| munchExp (T.BINOP(T.RSHIFT, e1, e2)) =
            			result (fn r => emit (oper("srlv `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE))) 

            	| munchExp (T.BINOP(T.ARSHIFT, e, T.CONST c)) =
            			result (fn r => emit (oper("sra `d0, `s0, " ^ iToS c, [r], [munchExp e], NONE))) 
            	| munchExp (T.BINOP(T.ARSHIFT, e1, e2)) =
            			result (fn r => emit (oper("srav `d0, `s0, `s1", [r], [munchExp e1, munchExp e2], NONE))) 


				| munchExp(T.MEM(T.CONST c)) = 
						result(fn r => emit(oper("lw `d0, " ^ iToS c ^ "($zero)", [r], [], NONE)))
				| munchExp(T.MEM(T.BINOP(T.PLUS, e, T.CONST c))) = 
						result(fn r => emit(oper("lw `d0, " ^ iToS c ^ "(`s0)", [r], [munchExp e], NONE)))
				| munchExp(T.MEM(T.BINOP(T.PLUS, T.CONST c, e))) = 
						result(fn r => emit(oper("lw `d0, " ^ iToS c ^ "(`s0)", [r], [munchExp e], NONE)))
				| munchExp(T.MEM(T.BINOP(T.MINUS, e, T.CONST c))) = 
						result(fn r => emit(oper("lw `d0, " ^ iToS (~c) ^ "(`s0)", [r], [munchExp e], NONE)))
				| munchExp(T.MEM e) = 
						result(fn r => emit(oper("lw `d0, 0(`s0)", [r], [munchExp e], NONE)))


				| munchExp (T.CALL(T.NAME lab, args)) =
						result(fn r => emit(oper("jal " ^ (Symbol.name lab), Frame.calldefs, munchArgs(0, args), NONE)))


				| munchExp(T.TEMP t) = t
				| munchExp(T.ESEQ (stm,exp)) = (munchStm stm; munchExp exp)
				| munchExp(T.NAME lab) = result(fn r => emit(oper("la `d0, " ^ Symbol.name lab, [r], [], NONE)))
				| munchExp(T.CONST c) = result(fn r => emit(oper("li `d0, " ^ iToS c, [r], [], NONE)))
				| munchExp _ = ErrorMsg.impossible "Could not munch expression"

		in munchStm stm;
			 rev(!ilist)
		end
end
