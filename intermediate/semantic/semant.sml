structure Semant :> Semantic =
struct

  structure A = Absyn;
  structure S = Symbol;
  structure Tr = Translate

  type venv = Env.enventry S.table
  type tenv = Types.ty S.table
  type expty = { exp: Tr.exp, ty: Types.ty }
  val teq = Types.eq

  (* generated for type errors, so this value won't actually be used *)
  val failExp = Tr.intLit 123456789 

  fun actualType(t: Types.ty, pos: int): Types.ty Log.log =
    let
      fun member(nil, elm) = false
        | member(x::rst, elm) = (S.id x) = (S.id elm) orelse member(rst, elm)
      fun join(lst) =
        String.concatWith "=" (map (fn s => S.name s) lst)

      fun helper(Types.NAME(s, tref), visited) =
        if member(visited, s)
        then Log.failure(Types.BOT, pos,
               ("Could not resolve types " ^ (join visited) ^
               " due to cyclic definition."))
        else
          (case !tref of
            SOME(typ) => helper(typ, s :: visited)
          | NONE => Log.failure(Types.BOT, pos, ("Could not resolve type " ^ (S.name s))))
          | helper(t, _) = Log.success(t)
    in
      helper(t, [])
    end

  (* Returns a string log version of a type *)
  fun typeToString(pos: int)(ty: Types.ty): string Log.log =
    case ty of
      Types.NIL => Log.success("Nil")
    | Types.INT => Log.success("Int")
    | Types.STRING => Log.success("String")
    | Types.UNIT => Log.success("Unit")
    | Types.BOT => Log.success("⊥")
    | Types.ARRAY(t, _) =>
        Log.flatMap(typeToString(pos)(t), fn x => Log.success("Array of " ^ x))
    | Types.RECORD(lst, id) => recordString(lst, pos)
    | Types.NAME(_, _) =>
      let
          val tts = typeToString(pos)
          val Types.NAME(sym, _) = ty
          val actual = actualType(ty, pos)
          val actualStr = Log.flatMap(actual, tts)
      in
          Log.map(actualStr, fn str => (S.name sym) ^ " = " ^ str)
      end

  and recordString(lst, pos): string Log.log =
      let
          fun parseField(sym, typ) =
              case typ of
                  Types.NAME(name, _) => Log.success(S.name name) (* don't dive in deeper *)
                | _ => typeToString(pos)(typ)
          val fields = Log.all (map parseField lst)
      in Log.map(fields, fn fields => "RECORD{" ^ (String.concatWith ", " fields) ^ "}")
      end

  fun checkInt(ty, pos): unit Log.log =
      Log.flatMap(actualType(ty, pos), fn at =>
      Log.flatMap(typeToString(pos)(ty), fn tStr =>
        if teq(at, Types.INT)
        then Log.success()
        else Log.failure((), pos, "Integer required, but was given " ^ tStr)))

  fun checkMatch(ty1, ty2, pos): unit Log.log =
      Log.flatMap(actualType(ty1, pos), fn at1 =>
      Log.flatMap(actualType(ty2, pos), fn at2 =>
      Log.flatMap(typeToString(pos)(ty1), fn tStr1 =>
      Log.flatMap(typeToString(pos)(ty2), fn tStr2 =>
        if teq(at1, at2)
        then Log.success()
        else Log.failure((), pos,  ("Types must match;\n" ^
                                    " | LHS: " ^ tStr1 ^ "\n" ^
                                    " | RHS: " ^ tStr2))))))


  fun checkType(ty1, ty2, pos, ctx): bool Log.log =
      Log.flatMap(actualType(ty1, pos), fn at1 =>
      Log.flatMap(actualType(ty2, pos), fn at2 =>
      Log.flatMap(typeToString(pos)(ty1), fn tStr1 =>
      Log.flatMap(typeToString(pos)(ty2), fn tStr2 =>
        if teq(at1, at2)
        then Log.success(true)
        else Log.failure(false, pos, (ctx ^ ": Types must match;\n" ^
                                      " | Expected: " ^ tStr1 ^ "\n" ^
                                      " | Actual: " ^ tStr2))))))

  fun checkMatchIntStr(ty1, ty2, pos): unit Log.log =
    Log.flatMap(actualType(ty1, pos), fn at1 =>
    Log.flatMap(actualType(ty2, pos), fn at2 =>
    Log.flatMap(typeToString(pos)(ty1), fn tStr1 =>
    Log.flatMap(typeToString(pos)(ty2), fn tStr2 =>
        if (teq(at1, Types.INT) andalso teq(at2, Types.INT)) orelse
           (teq(at1, Types.STRING) andalso teq(at2, Types.STRING))
        then Log.success()
        else Log.failure((), pos, ("Types must match and be either int or string.\n" ^
                                   " | LHS: " ^ tStr1 ^ "\n" ^
                                   " | RHS: " ^ tStr2))))))

  (* Checks for duplicated type definitions in the same recursive block *)
  fun checkForDuplicates (nil,nil) = Log.success()
    | checkForDuplicates ([],l) = Log.success()
    | checkForDuplicates (l,[]) = Log.success()
    | checkForDuplicates (name::nlist, pos::plist) =
      if (List.all (fn (x) => (name <> x)) nlist)
      then checkForDuplicates(nlist,plist)
      else Log.failure((), pos, "Duplicate definition found: " ^ S.name name)


  fun matchOrdered(nil, nil, pos, n, len) = Log.success()
    | matchOrdered(_, nil, pos, n, len) =
      Log.failure((), pos, ("Received less arguments than expected .\n" ^
                            " | Expected: " ^ (Int.toString len) ^ "\n" ^
                            " | Actual:   " ^ (Int.toString n)))
    | matchOrdered(nil, rst, pos, n, len) =
        Log.failure((), pos, ("Received more arguments than expected .\n" ^
                              " | Expected: " ^ (Int.toString len) ^ "\n" ^
                              " | Actual:   " ^ (Int.toString (n + length rst))))
    | matchOrdered(t1::rst1, t2::rst2, pos, n, len) =
        Log.flatMap(actualType(t1, pos), fn at1 =>
        Log.flatMap(actualType(t2, pos), fn at2 =>
        Log.flatMap(typeToString(pos)(t1), fn tStr1 =>
        Log.flatMap(typeToString(pos)(t2), fn tStr2 =>
        Log.flatMap(
          if teq(at1, at2)
          then Log.success()
          else Log.failure((), pos, ("Type mismatch at argument index " ^ (Int.toString n) ^ ".\n" ^
                                     " | Expected: " ^ tStr1 ^ "\n" ^
                                     " | Actual:   " ^ tStr2)),
          fn () => matchOrdered(rst1, rst2, pos, n+1, len))))))

  fun fieldName({name=name, escape=_, typ=_, pos=_}) = name

  fun transTy(tenv: tenv, typ: A.ty): Types.ty Log.log =
      let
      fun nameTy(sym, pos) =
        case S.look(tenv, sym) of
          SOME(t) => Log.success(t)
        | NONE => Log.failure(Types.BOT, pos, "Could not resolve type " ^ (S.name sym))
      fun recordTy(fields) =
        let
          fun trField({name, escape, typ, pos}) =
            case S.look(tenv, typ) of
              SOME(t) => Log.success((name, t))
            | NONE => Log.failure((name, Types.BOT), pos, "Could not resolve type " ^ (S.name typ))
          val recfields = Log.all (map trField fields)
        in
          Log.map(recfields, fn recfields => Types.RECORD(recfields, ref ()))
        end
      fun arrayTy(sym, pos) =
        case S.look(tenv, sym) of
          SOME(t) => Log.success(Types.ARRAY(t, ref ()))
        | NONE => Log.failure(Types.BOT, pos, "Could not resolve type " ^ (S.name sym))

    in
      case typ of
           A.NameTy(sym, pos) => nameTy(sym, pos)
         | A.RecordTy(fields) => recordTy(fields)
         | A.ArrayTy(sym, pos) => arrayTy(sym, pos)
    end

  and transVar(lvl: Tr.level, venv: venv, tenv: tenv, variable: A.var): expty Log.log =
    let
      fun simpleVar(sym, pos) =
        case S.look(venv, sym) of
          SOME(Env.VarEntry{access, ty}) =>
            Log.map(actualType(ty, pos), fn at =>
              { exp = Tr.simpleVar(access, lvl),  ty = at }) 
        | _ =>
            Log.failure({ exp = failExp, ty = Types.BOT }, pos, "Could not resolve variable " ^ (S.name sym))

      fun fieldVar(var, sym, pos) =
        let
          fun findSym(nil, s, pos, idx, varExp) =
                Log.failure({ exp = failExp, ty = Types.BOT }, pos, "Field ." ^ (S.name s) ^ " is not defined")
            | findSym((sym, t)::rst, s, pos, idx, varExp) =
                Log.flatMap(actualType(t, pos), fn at =>
                  if (S.id sym) = (S.id s)
                  then Log.success({ exp = Tr.fieldVar(varExp, idx), ty = at })
                  else findSym(rst, s, pos, idx+1))

          fun resolve({exp=varExp, ty=t}) =
            Log.flatMap(actualType(t, pos), fn at => 
              case at of
                Types.RECORD(fields, _) => findSym(fields, sym, pos, 0, varExp)
              | Types.BOT => Log.success({ exp = failExp, ty = Types.BOT })
              | _ => 
                Log.flatMap(typeToString pos t, fn tStr =>  
                  Log.failure({ exp = failExp, ty = Types.BOT }, pos, 
                              "RECORD type expected, but was given " ^ tStr)))
        in
          Log.flatMap(transVar(lvl, venv, tenv, var), resolve)
        end

      fun subscriptVar(var, exp, pos) =
        Log.flatMap(transVar(venv, tenv, var), fn ({exp=varExp, ty=ty}) =>
        Log.flatMap(actualType(ty, pos), fn at =>
        Log.flatMap(transExp(lvl, venv, tenv, exp), fn ({exp=expExp, ty=expTy}) =>
        Log.flatMap(checkInt(expTy, pos), fn () =>
          case at of
            Types.ARRAY(typ, _) => Log.success({ exp = Tr.subscript(varExp, expExp), ty = typ })
          | Types.BOT => Log.success({ exp = failExp, ty = Types.BOT })
          | _ => 
            Log.flatMap(typeToString pos ty, fn tStr =>  
              Log.failure({ exp = failExp, ty = Types.BOT }, pos, 
                          "ARRAY type expected, but was given " ^ tStr))))))

    in
      case variable of
           A.SimpleVar(sym, pos) => simpleVar(sym, pos)
         | A.FieldVar(var, sym, pos) => fieldVar(var, sym, pos)
         | A.SubscriptVar(var, exp, pos) => subscriptVar(var, exp, pos)
    end

  and transExp(lvl: Tr.level, venv: venv, tenv: tenv, expression: A.exp): expty Log.log =
    let

      fun trExp(expression: A.exp): expty Log.log = case expression of
         A.VarExp(var) => transVar(lvl, venv, tenv, var)
       | A.NilExp => Log.success({ exp=Tr.nilLit(), ty=Types.NIL })
       | A.IntExp(value) => Log.success({ exp=intLit value, ty=Types.INT })
       | A.StringExp(str, pos) => Log.success({ exp=strLit str, ty=Types.STRING })
       | A.CallExp{func, args, pos} => callExp(func, args, pos)
       | A.OpExp{left, oper, right, pos} => opExp(left, oper, right, pos)
       | A.RecordExp{fields, typ, pos} => recordExp(fields, typ, pos)
       | A.SeqExp(exps) => seqExp(exps)
       | A.AssignExp{var, exp, pos} => assignExp(var, exp, pos)
       | A.IfExp{test, then', else', pos} => ifExp(test, then', else', pos)
       | A.WhileExp{test, body, pos} => whileExp(test, body, pos)
       | A.ForExp{var, escape, lo, hi, body, pos} => forExp(var, escape, lo, hi, body, pos)
       | A.BreakExp(pos) => Log.success({exp=Tr.breakExp (Temp.newLabel()), ty=Types.UNIT})
       | A.LetExp{decs, body, pos} => letExp(decs, body, pos)
       | A.ArrayExp{typ, size, init, pos} => arrayExp(typ, size, init, pos)

      and seqExp(nil) = Log.success({ exp = Tr.seqExp nil, ty = Types.UNIT })
        | seqExp((exp, pos) :: nil) = trExp(exp)
        | seqExp((exp, pos) :: exps) = Log.flatMap(trExp(exp), fn (_) => seqExp(exps))

      and checkMatchTwoInt(oper, left, right, pos) = 
        Log.flatMap(trExp left, fn ({exp=leftExp, ty=leftTy}) =>
        Log.flatMap(trExp right, fn ({exp=rightExp, ty=rightTy}) =>
        Log.flatMap(checkInt(leftTy, pos), fn () =>
        Log.flatMap(checkInt(rightTy, pos), fn () =>
          Log.success({exp=Tr.binop(oper, leftExp, rightExp), ty=Types.INT})))))

      and checkMatchTwoEq(left, right, pos) = 
        Log.flatMap(trExp left, fn ({exp=leftExp, ty=leftTy}) =>
        Log.flatMap(trExp right, fn ({exp=rightExp, ty=rightTy}) =>
        Log.flatMap(checkMatch(leftTy, rightTy, pos), fn () => 
          Log.success({exp=Tr.relop(oper, leftExp, rightExp), ty=Types.INT}))))

      and checkMatchTwoIntStr(left, right, pos) = 
        Log.flatMap(trExp left, fn ({exp=leftExp, ty=leftTy}) =>
        Log.flatMap(trExp right, fn ({exp=rightExp, ty=rightTy}) =>
        Log.flatMap(checkMatchIntStr(leftTy, rightTy, pos), fn () => 
          Log.success({exp=Tr.relop(oper, leftExp, rightExp), ty=Types.INT}))))

      and opExp(left, A.PlusOp, right, pos) = checkMatchTwoInt(A.PlusOp, left, right, pos)
        | opExp(left, A.MinusOp, right, pos) = checkMatchTwoInt(A.MinusOp, left, right, pos)
        | opExp(left, A.TimesOp, right, pos) = checkMatchTwoInt(A.TimesOp, left, right, pos)
        | opExp(left, A.DivideOp, right, pos) = checkMatchTwoInt(A.DivideOp, left, right, pos)
        | opExp(left, A.EqOp, right, pos) = checkMatchTwoEq(A.EqOp, left, right, pos)
        | opExp(left, A.NeqOp, right, pos) = checkMatchTwoEq(A.NeqOp, left, right, pos)
        | opExp(left, A.LtOp, right, pos) = checkMatchTwoIntStr(A.LtOp, left, right, pos)
        | opExp(left, A.LeOp, right, pos) = checkMatchTwoIntStr(A.LeOp, left, right, pos)
        | opExp(left, A.GtOp, right, pos) = checkMatchTwoIntStr(A.GtOp, left, right, pos)
        | opExp(left, A.GeOp, right, pos) = checkMatchTwoIntStr(A.GeOp, left, right, pos)

      and callExp(func, args, pos) =
        case S.look(venv, func) of
             SOME(Env.FunEntry{formals, result}) =>
               let
                 val translated = Log.all (map trExp args)
                 val types = Log.map(translated, fn lst => map (fn ({exp, ty}) => ty) lst)
                 val res = Log.flatMap(types, fn lst =>
                  matchOrdered(List.rev formals, List.rev lst, pos, 0, length formals))
               in
                 Log.map(res, fn (_) => { exp = (), ty = result })
               end
           | _ =>
               Log.failure({ exp = (), ty = Types.BOT }, pos, "Undefined function " ^ (S.name func))

      and letExp(decs, body, pos) =
        Log.flatMap(transDecs(lvl, venv, tenv, decs), fn ({venv, tenv}) => transExp(lvl, venv, tenv, body))

      and recordExp(fields, typ, pos) =
          case S.look(tenv,typ) of
            NONE => Log.failure({ exp = (), ty = Types.BOT }, pos, "Undefined record type " ^ (S.name typ))
          | SOME t =>
            Log.flatMap(actualType(t, pos), fn at =>
            Log.flatMap(typeToString(pos)(t), fn tStr =>
              case at of 
                Types.RECORD(fieldTypes, unique) => 
                  Log.flatMap(
                    Log.all(map (fn (sym,exp,pos) => Log.map (trExp exp, fn texp => (sym, texp))) fields),
                    fn transFields => 
                      if (length(fieldTypes) <> length(transFields)) then
                        Log.failure({ exp = (), ty = Types.BOT}, pos,
                        "Record expected " ^ (Int.toString (length(fieldTypes))) ^ " fields, " ^ 
                        "but " ^ (Int.toString (length(transFields))) ^ " fields given")
                      else
                        (* This can be reworked... *)
                        let
                          val mergedList = map 
                            (fn (sym, {exp, ty}) => 
                              let
                                val fieldItem = List.find 
                                  (fn (fsym, fty) => ((Symbol.id fsym) = (Symbol.id sym) 
                                                      andalso 
                                                      (Log.valueOf (checkType(fty, ty, pos, "Record declaration"))))) fieldTypes
                              in
                                case fieldItem of
                                  NONE => NONE
                                | SOME (fsym, fty) => SOME (sym, exp, ty, pos)
                              end
                            ) transFields
                        in
                          if isSome (List.find (fn item => not (isSome item)) mergedList) then
                            Log.failure({exp=(), ty=Types.BOT}, pos, "Record declarations invalid")
                          else
                            Log.success({exp=(), ty=t})
                        end)
              | _ => 
                  Log.failure({exp=(), ty=Types.BOT}, pos, "Record type mismatch, given " ^ tStr)))

      and ifExp(test, then', else', pos) =
        Log.flatMap(trExp then', fn {exp=thenexp, ty=thenty} => 
        Log.flatMap(trExp test, fn {exp=testexp, ty=testty} => 
        Log.flatMap(checkInt(testty, pos), fn () => 
        Log.flatMap(
          case else' of
            NONE => Log.success NONE
          | SOME(e) =>
              Log.map(trExp e, fn {exp=elseexp,ty=elsety} => SOME(elseexp, elsety)),

          fn elseexp => 
            case elseexp of
              NONE => 
                Log.map(checkType(Types.UNIT, thenty, pos, "If-then"), fn verdict =>
                  if verdict 
                  then {exp=(),ty=Types.UNIT}
                  else {exp=(),ty=Types.BOT})
            | SOME(e, t) => 
                Log.map(checkType(thenty, t, pos, "If-then-else"), fn verdict =>
                  if verdict
                  then {exp=(),ty=thenty}
                  else {exp=(),ty=Types.BOT})))))

      and whileExp(test, body, pos) =
        Log.flatMap(trExp test, fn {exp=testexp,ty=testty} => 
        Log.flatMap(trExp body, fn {exp=bodyexp,ty=bodyty} => 
        Log.flatMap(checkType(Types.INT,testty,pos, "While-test"), fn testIsInt => 
        Log.map(checkType(Types.UNIT,bodyty,pos, "While-body"), fn bodyIsUnit => 
            if testIsInt andalso bodyIsUnit 
            then {exp=(), ty=Types.UNIT}
            else {exp=(), ty=Types.BOT}))))

      and forExp(var, escape, lo, hi, body, pos) =
        let
          val venvNew = S.enter (venv, var, Env.VarEntry {ty=Types.INT})
        in
          Log.flatMap(transExp(lvl, venvNew, tenv, lo), fn {exp=loexp,ty=loty} => 
          Log.flatMap(transExp(lvl, venvNew, tenv, hi), fn {exp=hiexp,ty=hity} => 
          Log.flatMap(transExp(lvl, venvNew, tenv, body), fn {exp=bodyexp,ty=bodyty} => 
          Log.flatMap(checkType(Types.INT, loty,pos, "For-lo"), fn loIsInt => 
          Log.flatMap(checkType(Types.INT, hity,pos, "For-hi"), fn hiIsInt => 
          Log.map(checkType(Types.UNIT, bodyty,pos, "For-body"), fn bodyIsUnit => 
            if loIsInt andalso hiIsInt andalso bodyIsUnit 
            then {exp=(),ty=Types.UNIT}
            else {exp=(),ty=Types.BOT}))))))
        end

      and arrayExp(typ, size, init, pos) =
          case S.look(tenv,typ) of
            NONE => Log.failure({exp=(), ty=Types.BOT}, pos, "Array type " ^ (S.name typ) ^ " not found")
          | SOME(t) =>
              Log.flatMap(actualType(t,pos), fn at => 
                case at of
                  Types.ARRAY(arrayType,unique) =>
                    Log.flatMap(trExp size, fn {exp=sizeexp,ty=sizety} =>
                    Log.flatMap(trExp init, fn {exp=initexp,ty=initty} =>
                    Log.flatMap(checkType(Types.INT, sizety, pos, "Array Size"), fn sizeIsInt => 
                    Log.map(checkType(arrayType, initty, pos, "Array Type"), fn arrSameType => 
                      if sizeIsInt andalso arrSameType
                      then {exp=(), ty=t}
                      else {exp=(), ty=Types.BOT}))))
                | _ => 
                    Log.flatMap(typeToString pos t, fn tyStr =>  
                      Log.failure({exp=(), ty=Types.BOT}, pos, "Array expected, given " ^ tyStr)))

      and assignExp(var, exp, pos) =
        Log.flatMap(transVar (venv, tenv, var), fn {exp=varexp,ty=varty} => 
        Log.flatMap(trExp exp, fn {exp=expexp,ty=expty} => 
        Log.map(checkType (varty, expty, pos, "Assign"), fn isSameType => 
          if isSameType
          then {exp=(),ty=Types.UNIT}
          else {exp=(), ty = Types.BOT})))
    in
      trExp expression
    end


  and transDecs(lvl: Tr.level, venv: venv, tenv: tenv, decs: A.dec list): { venv: venv, tenv: tenv} Log.log =
    let
      fun reduce(dec, envs) =
        Log.flatMap(envs, fn ({venv, tenv}) => transDec(lvl, venv, tenv, dec))
    in
      foldl reduce (Log.success({venv=venv, tenv=tenv})) decs
    end

  and transDec(lvl: Tr.level, venv: venv, tenv: tenv, declaration: A.dec): { venv: venv, tenv: tenv } Log.log =
    let
      fun varDec(name, escape, typ, init, pos) =
        Log.flatMap(transExp(lvl, venv, tenv, init), fn ({exp=_, ty=initType}) =>
        Log.flatMap(actualType(initType, pos), fn actualInitType =>
        Log.flatMap(
          case typ of
            SOME((s, _)) =>
              (case S.look(tenv, s) of
                 SOME(t) => Log.success(t)
               | NONE => Log.failure(Types.BOT, pos, "Undeclared type " ^ (S.name s)))
          | NONE => 
            case actualInitType of
              Types.NIL => Log.failure(Types.BOT, pos, 
                             "The variable must explicitly specify a RECORD type to initialize with nil")
            | _ => Log.success(initType),
          fn decType =>
        Log.flatMap(actualType(decType, pos), fn actualDecType =>
        Log.flatMap(typeToString(pos)(initType), fn initTypeStr =>
        Log.flatMap(typeToString(pos)(decType), fn decTypeStr =>
          if teq(actualInitType, actualDecType)
          then Log.success({venv=S.enter(venv, name, Env.VarEntry{ty=decType}),
                            tenv=tenv})
          else Log.failure(
                {venv=S.enter(venv, name, Env.VarEntry{ty=decType}),
                 tenv=tenv}, pos,
                 ("The initializer's type does not " ^
                 "match the declared type.\n" ^
                 "| Initializer: " ^ initTypeStr ^ "\n" ^
                 "| Declared:    " ^ decTypeStr))))))))

      fun typeDecs(typedecs) =
        let
          val uniqueSet = foldl
            (fn (tdec, acc) => 
              let val {name, ty, pos} = tdec 
              in
                Log.flatMap(acc, fn acc => 
                  if List.exists (fn {name=name', ty=_, pos=_} => name = name') acc
                  then Log.failure(acc, pos, "Redundant type declaration: " ^ (S.name name))
                  else Log.success(tdec :: acc))
              end)
            (Log.success [])
            typedecs

          val headerEnv = 
            Log.map(uniqueSet, 
              fn uniqueSet => foldl (fn ({name, ty, pos}, acc) => 
                                      S.enter(acc, name, Types.NAME(name, ref NONE)))
                                    tenv
                                    uniqueSet)
  
          val logs = 
            Log.flatMap(headerEnv, fn headerEnv => 
            Log.flatMap(uniqueSet, fn uniqueSet =>
              Log.all (
                map (fn ({name, ty, pos}) =>
                       Log.map(transTy(headerEnv, ty), fn ty =>
                         let val SOME(Types.NAME(_, r)) = S.look(headerEnv, name)
                         in r := SOME(ty)
                         end))
                    uniqueSet
            )))

          fun checkCycle(headerEnv, uniqueSet) = foldr
            (fn ({name, ty, pos}, acc) => 
              Log.flatMap(acc, fn acc =>
                case S.look(headerEnv, name) of
                  SOME(t) => 
                    Log.map(actualType(t, pos), fn at =>
                      case at of
                        Types.BOT => 
                          (case t of 
                            Types.NAME(sym, r) => r := SOME(Types.BOT)
                          |  _ => ())
                     |  _ => ()
                    )
                | NONE => Log.failure((), pos, "Something's wrong... the type isn't added to the env")))
            (Log.success())
            uniqueSet

        in
          Log.flatMap(uniqueSet, fn uniqueSet => 
          Log.flatMap(headerEnv, fn headerEnv => 
          Log.flatMap(checkCycle(headerEnv, uniqueSet), fn () => 
          Log.map(logs, fn (_) => { venv = venv, tenv = headerEnv }))))
        end

      fun functionDecs(fundecs) =
        let

          fun fieldToTy({name=_, escape=_, typ=sym, pos=pos}) =
            case S.look(tenv, sym) of
              SOME(ty) => actualType(ty, pos)
            | NONE => Log.failure(Types.BOT, pos, "Undeclared type " ^ (S.name sym));

          fun resultToTy(NONE) = Log.success(Types.UNIT)
            | resultToTy(SOME(sym, pos)) =
                case S.look(tenv, sym) of
                  SOME(ty) => actualType(ty, pos)
                | NONE => Log.failure(Types.BOT, pos, "Undeclared type " ^ (S.name sym));

          val uniqueSet = foldl
            (fn (fdec, acc) => 
              let val {name, params, result, body, pos} = fdec 
              in
                Log.flatMap(acc, fn acc => 
                  if List.exists (fn {name=name', params=_, result=_, body=_, pos=_} => name = name') acc
                  then Log.failure(acc, pos, "Redundant function declaration: " ^ (S.name name))
                  else Log.success(fdec :: acc))
              end)
            (Log.success [])
            fundecs 

          val headerEnv = 
            Log.flatMap(uniqueSet, fn uniqueSet =>
              foldr
              (fn ({name, params, result, body, pos}, acc) =>
                Log.flatMap(acc, fn env =>
                Log.flatMap(Log.all (map fieldToTy params), fn paramTys =>
                Log.map(resultToTy result, fn resultTy =>
                  S.enter(env, name, Env.FunEntry{formals=paramTys, result=resultTy})))))
              (Log.success venv)
              uniqueSet
            )

          fun withParams(params, venv) = foldl
            (fn (field, acc) =>
              Log.flatMap(acc, fn acc =>
              Log.map(fieldToTy field, fn fieldTy =>
                S.enter(acc, fieldName field, Env.VarEntry{ty=fieldTy}))))
            (Log.success venv)
            params

          fun bodyCheck({name, params, result, body, pos}) =
            Log.flatMap(headerEnv, fn env =>
            Log.flatMap(withParams(params, env), fn funEnv =>
            Log.flatMap(transExp(lvl, funEnv, tenv, body), fn ({exp=_, ty=resTy}) =>
            Log.flatMap(resultToTy result, fn decResTy =>
            Log.flatMap(actualType(resTy, pos), fn resAT =>
            Log.flatMap(actualType(decResTy, pos), fn decResAT =>
            Log.flatMap(typeToString(pos)(resTy), fn resTyStr =>
            Log.flatMap(typeToString(pos)(decResTy), fn decResTyStr =>
              if teq(resAT, decResAT)
              then Log.success()
              else Log.failure((), pos, ("The body's result type and declared result type " ^
                                         "does not match. \n" ^
                                         " | Declared: " ^ decResTyStr ^ "\n" ^
                                         " | Actual:   " ^ resTyStr))))))))))

          val logs = Log.all (map bodyCheck fundecs)
        in
          Log.flatMap(logs, fn (_) =>
          Log.map(headerEnv, fn headerEnv =>
            { venv = headerEnv, tenv = tenv }))
        end
    in
      case declaration of
           A.FunctionDec(fundecs) => functionDecs(fundecs)
         | A.VarDec{name, escape, typ, init, pos} => varDec(name, escape, typ, init, pos)
         | A.TypeDec(typedecs) => typeDecs(typedecs)
    end

  fun transProg (absyn: A.exp): unit =
    let 
      val mainLevel = Tr.newLevel({parent=Tr.outerMost, name=Temp.namedLabel "main", formals=[]})
    in
      (Log.report (transExp(mainLevel, Tr.Env.base_venv, Env.base_tenv, absyn)); ())
    end
end

