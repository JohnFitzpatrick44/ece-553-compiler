structure Semant = 
struct
  structure A = Absyn;

  type venv = Env.enventry Symbol.table
  type tenv = Types.ty Symbol.table

  type expty = { exp: Translate.exp, ty: Types.ty }

  val PLACEHOLDER: expty = { exp = (), ty = Types.UNIT }

  fun printType(Types.RECORD(_, _)) = print "record\n"
    | printType(Types.NIL) = print "nil\n"
    | printType(Types.INT) = print "int\n"
    | printType(Types.STRING) = print "string\n"
    | printType(Types.ARRAY(_, _)) = print "array\n"
    | printType(Types.UNIT) = print "unit\n"
    | printType(Types.NAME(_, _)) = print "name\n"

  fun checkInt({exp, ty}, pos) = 
    if ty = Types.INT
    then ()
    else ErrorMsg.error pos "Integer required"

  fun checkMatch({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = 
    if ty1 = ty2
    then ()
    else ErrorMsg.error pos "Types must match."

  fun checkMatchIntStr({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = 
    if (ty1 = Types.INT andalso ty2 = Types.INT) orelse (ty1 = Types.STRING andalso ty2 = Types.STRING)
    then ()
    else ErrorMsg.error pos "Types must match and be either int or string."

  fun transVar(venv: venv, tenv: tenv, variable: A.var): expty = 
    case variable of
         A.SimpleVar(sym, pos) => PLACEHOLDER
       | A.FieldVar(var, sym, pos) => PLACEHOLDER
       | A.SubscriptVar(var, sym, pos) => PLACEHOLDER

  and transExp(venv: venv, tenv: tenv, expression: A.exp): expty = 
    let

      fun trExp(expression: A.exp): expty = case expression of
         A.VarExp(var) => PLACEHOLDER
       | A.NilExp => { exp=(), ty=Types.UNIT }
       | A.IntExp(value) => { exp=(), ty=Types.INT }
       | A.StringExp(str, pos) => { exp=(), ty=Types.STRING }
       | A.CallExp{func, args, pos} => PLACEHOLDER
       | A.OpExp{left, oper, right, pos} => opExp(left, oper, right, pos)
       | A.RecordExp{fields, typ, pos} => PLACEHOLDER
       | A.SeqExp(exps) => seqExp(exps)
       | A.AssignExp{var, exp, pos} => PLACEHOLDER
       | A.IfExp{test, then', else', pos} => PLACEHOLDER
       | A.WhileExp{test, body, pos} => PLACEHOLDER
       | A.ForExp{var, escape, lo, hi, body, pos} => PLACEHOLDER
       | A.BreakExp(pos) => PLACEHOLDER
       | A.LetExp{decs, body, pos} => PLACEHOLDER
       | A.ArrayExp{typ, size, init, pos} => PLACEHOLDER

      and seqExp(nil) = { exp = (), ty = Types.UNIT }
        | seqExp((exp, pos) :: nil) = trExp(exp) 
        | seqExp((exp, pos) :: exps) = (trExp(exp); seqExp(exps))

      and opExp(left, A.PlusOp, right, pos) = (checkInt(trExp left, pos); checkInt(trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.MinusOp, right, pos) = (checkInt(trExp left, pos); checkInt(trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.TimesOp, right, pos) = (checkInt(trExp left, pos); checkInt(trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.DivideOp, right, pos) = (checkInt(trExp left, pos); checkInt(trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.EqOp, right, pos) = (checkMatch(trExp left, trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.NeqOp, right, pos) = (checkMatch(trExp left, trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.LtOp, right, pos) = (checkMatchIntStr(trExp left, trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.LeOp, right, pos) = (checkMatchIntStr(trExp left, trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.GtOp, right, pos) = (checkMatchIntStr(trExp left, trExp right, pos); {exp=(), ty=Types.INT})
        | opExp(left, A.GeOp, right, pos) = (checkMatchIntStr(trExp left, trExp right, pos); {exp=(), ty=Types.INT})

    in
      trExp expression
    end

  and transDec(venv: venv, tenv: tenv, declaration: A.dec): { venv: venv, tenv: tenv } = 
    case declaration of
         A.FunctionDec(fundecs) => { venv = venv, tenv = tenv }
       | A.VarDec{name, escape, typ, init, pos} => { venv = venv, tenv = tenv }
       | A.TypeDec(typedecs) => { venv = venv, tenv = tenv }

  and transTy(tenv: tenv, typ: A.ty): Types.ty = 
    case typ of
         A.NameTy(sym, pos) => Types.UNIT
       | A.RecordTy(fields) => Types.UNIT
       | A.ArrayTy(sym, pos) => Types.UNIT

  fun transProg (absyn: A.exp): unit = 
    ( transExp(Env.base_venv, Env.base_tenv, absyn); ())
end
