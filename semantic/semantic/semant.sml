structure Semant = 
struct
  structure A = Absyn;

  type venv = Env.enventry Symbol.table
  type tenv = Types.ty Symbol.table

  type expty = { exp: Translate.exp, ty: Types.ty }

  val PLACEHOLDER: expty = { exp = (), ty = Types.UNIT }

  fun transVar(venv: venv, tenv: tenv, variable: A.var): expty = 
    case variable of
         A.SimpleVar(sym, pos) => PLACEHOLDER
       | A.FieldVar(var, sym, pos) => PLACEHOLDER
       | A.SubscriptVar(var, sym, pos) => PLACEHOLDER

  and transExp(venv: venv, tenv: tenv, expression: A.exp): expty = 
    let
      fun trExp(expression: A.exp): expty = case expression of
         A.VarExp(var) => PLACEHOLDER
       | A.NilExp => PLACEHOLDER
       | A.IntExp(value) => PLACEHOLDER
       | A.StringExp(str, pos) => PLACEHOLDER
       | A.CallExp{func, args, pos} => PLACEHOLDER
       | A.OpExp{left, oper, right, pos} => PLACEHOLDER
       | A.RecordExp{fields, typ, pos} => PLACEHOLDER
       | A.SeqExp(exps) => PLACEHOLDER
       | A.AssignExp{var, exp, pos} => PLACEHOLDER
       | A.IfExp{test, then', else', pos} => PLACEHOLDER
       | A.WhileExp{test, body, pos} => PLACEHOLDER
       | A.ForExp{var, escape, lo, hi, body, pos} => PLACEHOLDER
       | A.BreakExp(pos) => PLACEHOLDER
       | A.LetExp{decs, body, pos} => PLACEHOLDER
       | A.ArrayExp{typ, size, init, pos} => PLACEHOLDER
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
