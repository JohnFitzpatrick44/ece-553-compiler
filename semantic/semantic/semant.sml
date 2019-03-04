structure Semant = 
struct
  structure A = Absyn;
  structure S = Symbol;

  type venv = Env.enventry S.table
  type tenv = Types.ty S.table

  type expty = { exp: Translate.exp, ty: Types.ty }

  val teq = Types.eq

  val PLACEHOLDER: expty = { exp = (), ty = Types.UNIT }

  fun typeToString(Types.RECORD(lst, _)) = "RECORD(" ^ (String.concatWith "," (map (fn (_, t) => typeToString t) lst)) ^ ")"
    | typeToString(Types.NIL) = "Nil"
    | typeToString(Types.INT) = "Int"
    | typeToString(Types.STRING) = "String"
    | typeToString(Types.ARRAY(t, _)) = "Array of " ^ (typeToString t)
    | typeToString(Types.UNIT) = "Unit"
    | typeToString(Types.NAME(name, _)) = "Name(" ^ (S.name name) ^ ")"
    | typeToString(Types.BOT) = "⊥"

  fun checkInt({exp, ty}, pos) = 
    if teq (ty, Types.INT)
    then ()
    else ErrorMsg.error pos 
          ("Integer required, but was given " ^ (typeToString ty))

  fun checkMatch({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = 
    if teq(ty1, ty2)
    then ()
    else ErrorMsg.error pos 
          ("Types must match; LHS: " ^ (typeToString ty1) ^ 
           ", RHS: " ^ (typeToString ty2))

  fun checkMatchIntStr({exp=exp1, ty=ty1}, {exp=exp2, ty=ty2}, pos) = 
    if (teq(ty1, Types.INT) andalso teq(ty2, Types.INT)) orelse 
       (teq(ty1, Types.STRING) andalso teq(ty2, Types.STRING))
    then ()
    else ErrorMsg.error pos 
          ("Types must match and be either int or string. " ^ 
           "LHS: " ^ (typeToString ty1) ^ ", RHS: " ^ (typeToString ty2))

  fun matchOrdered(nil, nil, pos, n, len) = ()
    | matchOrdered(_, nil, pos, n, len) = 
        ErrorMsg.error pos 
          ("Received less arguments than expected .\n" ^
           "| Expected: " ^ (Int.toString len) ^ "\n" ^
           "| Actual:   " ^ (Int.toString n))
    | matchOrdered(nil, rst, pos, n, len) = 
        ErrorMsg.error pos 
          ("Received more arguments than expected .\n" ^
           "| Expected: " ^ (Int.toString len) ^ "\n" ^
           "| Actual:   " ^ (Int.toString (n + length rst)))
    | matchOrdered(t1::rst1, t2::rst2, pos, n, len) = 
      (
        if teq(t1, t2)
        then ()
        else ErrorMsg.error pos 
              ("Type mismatch at argument index " ^ (Int.toString n) ^ ".\n" ^
               "| Expected: " ^ (typeToString t1) ^ "\n" ^
               "| Actual:   " ^ (typeToString t2));

        matchOrdered(rst1, rst2, pos, n+1, len)
      )

  fun actualType(t, pos) =
    let 
      fun member(nil, elm) = false
        | member(x::rst, elm) = (S.id x) = (S.id elm) orelse member(rst, elm)
      fun join(lst) = 
        "[" ^ (String.concatWith "," (map (fn s => S.name s) lst)) ^ "]"
           
      fun helper(Types.NAME(s, tref), visited) = 
        if member(visited, s)
        then (ErrorMsg.error pos 
                ("Could not resolve types " ^ (join visited) ^ 
                 " due to cyclic definition."); 
              Types.BOT)
        else
          (case !tref of
            SOME(typ) => helper(typ, s :: visited)
          | NONE => 
              (ErrorMsg.error pos ("Could not resolve type " ^ (S.name s));
              Types.BOT))
        | helper(t, visited) = t
    in
      helper(t, [])
    end

  fun transTy(tenv: tenv, typ: A.ty): Types.ty = 
    let
      fun nameTy(sym, pos) = 
        case S.look(tenv, sym) of
          SOME(t) => t
        | NONE => 
            (ErrorMsg.error pos ("Could not resolve type " ^ (S.name sym));
            Types.BOT)
    in
      case typ of
           A.NameTy(sym, pos) => nameTy(sym, pos)
         | A.RecordTy(fields) => Types.UNIT
         | A.ArrayTy(sym, pos) => Types.UNIT
    end

  and transVar(venv: venv, tenv: tenv, variable: A.var): expty = 
    let 
      fun simpleVar(sym, pos) = 
        case S.look(venv, sym) of
             SOME(Env.VarEntry{ty}) => { exp = (), ty = actualType(ty, pos) }
           | _ => (ErrorMsg.error pos ("Could not resolve variable " ^ (S.name sym)); 
                  { exp = (), ty = Types.BOT })

      fun fieldVar(var, sym, pos) = 
        let 
          fun findSym(nil, s, pos) =  
              (ErrorMsg.error pos ("Field " ^ (S.name s) ^ " does not exist"); 
              { exp = (), ty = Types.BOT })
            | findSym((sym, t)::rst, s, pos) = 
                if (S.id sym) = (S.id s)
                then { exp = (), ty = actualType(t, pos) }
                else findSym(rst, s, pos)
          val {exp=_, ty=t} = transVar(venv, tenv, var)
        in
          case t of
               Types.RECORD(fields, _) => findSym(fields, sym, pos)
             | _ => { exp = (), ty = Types.BOT }
        end
    in
      case variable of
           A.SimpleVar(sym, pos) => simpleVar(sym, pos)
         | A.FieldVar(var, sym, pos) => fieldVar(var, sym, pos)
         | A.SubscriptVar(var, sym, pos) => PLACEHOLDER
    end

  and transExp(venv: venv, tenv: tenv, expression: A.exp): expty = 
    let

      fun trExp(expression: A.exp): expty = case expression of
         A.VarExp(var) => transVar(venv, tenv, var)
       | A.NilExp => { exp=(), ty=Types.NIL }
       | A.IntExp(value) => { exp=(), ty=Types.INT }
       | A.StringExp(str, pos) => { exp=(), ty=Types.STRING }
       | A.CallExp{func, args, pos} => callExp(func, args, pos)
       | A.OpExp{left, oper, right, pos} => opExp(left, oper, right, pos)
       | A.RecordExp{fields, typ, pos} => PLACEHOLDER
       | A.SeqExp(exps) => seqExp(exps)
       | A.AssignExp{var, exp, pos} => PLACEHOLDER
       | A.IfExp{test, then', else', pos} => PLACEHOLDER
       | A.WhileExp{test, body, pos} => PLACEHOLDER
       | A.ForExp{var, escape, lo, hi, body, pos} => PLACEHOLDER
       | A.BreakExp(pos) => PLACEHOLDER
       | A.LetExp{decs, body, pos} => letExp(decs, body, pos)
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

      and callExp(func, args, pos) = 
        case S.look(venv, func) of 
             SOME(Env.FunEntry{formals, result}) => 
               let
                 val trAndStripped = map (fn ({exp, ty}) => ty) (map trExp args) 
               in
                 (matchOrdered(formals, trAndStripped, pos, 0, length formals); 
                 { exp = (), ty = result })
               end
           | _ => 
               (ErrorMsg.error pos ("Undefined function " ^ (S.name func)); 
               { exp = (), ty = Types.BOT })
      and letExp(decs, body, pos) = 
        let val {venv=venv', tenv=tenv'} = transDecs(venv, tenv, decs)
        in transExp(venv', tenv', body)
        end

    in
      trExp expression
    end

  and transDecs(venv: venv, tenv: tenv, decs: A.dec list): { venv: venv, tenv: tenv} = 
      foldl (fn (dec, { venv = venv', tenv = tenv' } ) => 
              transDec(venv', tenv', dec)) {venv=venv, tenv=tenv} decs

  and transDec(venv: venv, tenv: tenv, declaration: A.dec): { venv: venv, tenv: tenv } = 
    let
      fun varDec(name, escape, typ, init, pos) = 
        let 
          val {exp=_, ty=iT} = transExp(venv, tenv, init);
          val initT = actualType(iT, pos)
        in
          case typ of 
            SOME((s, _)) => (
              case S.look(tenv,s) of
                SOME(t') => 
                  let val t = actualType(t', pos)
                  in
                    if teq(initT, t)
                    then {venv=S.enter(venv, name, Env.VarEntry{ty=t}), tenv=tenv}
                    else (
                      ErrorMsg.error pos 
                        ("The initializer's type does not " ^ 
                        "match the declared type.\n" ^
                        "| Initializer: " ^ (typeToString initT) ^ "\n" ^
                        "| Declared:    " ^ (typeToString t));
                        { venv=S.enter(venv, name, Env.VarEntry{ty=t}), 
                          tenv=tenv }
                    )
                  end
              | NONE => 
                    (ErrorMsg.error pos ("Undeclared type " ^ (S.name s));
                     { venv=S.enter(venv, name, Env.VarEntry{ty=Types.BOT}), 
                       tenv=S.enter(tenv, s, Types.BOT) })
            )
          | NONE => { venv=S.enter(venv, name, Env.VarEntry{ty=initT}), tenv=tenv }
        end
      fun typeDecs(typedecs) = 
        let 
          val headerEnv = foldl
            (fn ({name, ty, pos}, acc) => S.enter(acc, name, Types.NAME(name, ref NONE)))
            tenv 
            typedecs

          fun trAndAssign(name, ty, pos) = 
            let val translated = transTy(headerEnv, ty)
            in
              case S.look(headerEnv, name) of
                SOME(Types.NAME(_, r)) => r := SOME(translated)
              | _ => ()
            end

          val () = 
            app (fn ({name, ty, pos}) => trAndAssign(name, ty, pos)) typedecs
        in
          { venv = venv, tenv = headerEnv }
        end 
    in
      case declaration of
           A.FunctionDec(fundecs) => { venv = venv, tenv = tenv }
         | A.VarDec{name, escape, typ, init, pos} => varDec(name, escape, typ, init, pos)
         | A.TypeDec(typedecs) => typeDecs typedecs
    end

  fun transProg (absyn: A.exp): unit = 
    ( transExp(Env.base_venv, Env.base_tenv, absyn); ())
end
