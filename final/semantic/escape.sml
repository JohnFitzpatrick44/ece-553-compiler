structure FindEscape :> FIND_ESCAPE = 
struct
  type depth = int * Symbol.symbol (* function symbol *)
  type escEnv = (depth * bool ref) Symbol.table

  fun cmpDepth((d1, _), (d2, _)) = d1 < d2
  fun cmpDepthEq((d1, _), (d2, _)) = d1 <= d2

  structure A = Absyn
  structure S = Symbol

  fun doIfSome(f, SOME a) = f a
    | doIfSome(f, NONE) = ()

  fun traverseVar(env: escEnv, d: depth, var: A.var): unit = 
    let 
      fun trVar(A.SimpleVar(sym, _)) = 
            (case S.look(env, sym) of
              SOME((d', r)) => if cmpDepth(d', d) then r := true else ()
            | NONE => ())
        | trVar(A.FieldVar(var, _, _)) = trVar var
        | trVar(A.SubscriptVar(var, exp, _)) = (traverseExp(env, d, exp); trVar var)
    in
      trVar var
    end

  and traverseExp(env: escEnv, d: depth, exp: A.exp): unit = 
    let 
      fun trExp(A.VarExp(var)) = traverseVar(env, d, var)
        | trExp(A.NilExp) = ()
        | trExp(A.IntExp(_)) = ()
        | trExp(A.StringExp(_,_)) = ()
        | trExp(A.CallExp{func,args,pos}) = (
            S.app (fn ((depth, fsym), r) => let 
                                              (* val _ = print ("depth: " ^ (Int.toString depth) ^ ", fsym: " ^ (Symbol.name fsym)) *)
                                              (* val _ = print ("current depth: " ^ (Int.toString (#1 d))) *)
                                            in
                                              if fsym = func andalso cmpDepthEq((depth, fsym), d) 
                                              then r := true
                                              else ()
                                            end) env ; 
            List.app trExp args
          )
        | trExp(A.OpExp{left,oper,right,pos}) = (trExp left; trExp right)
        | trExp(A.RecordExp{fields,typ,pos}) = 
            List.app (fn (symbol, exp, pos) => trExp exp) fields
        | trExp(A.SeqExp(exps)) = 
            List.app (fn (exp, _) => traverseExp(env, d, exp)) exps
        | trExp(A.AssignExp{var,exp,pos}) = (traverseVar(env, d, var); trExp exp)
        | trExp(A.IfExp{test,then',else',pos}) = 
        (trExp test; trExp then'; doIfSome(trExp, else'))
        | trExp(A.WhileExp{test,body,pos}) = (trExp test; trExp body)
        | trExp(A.ForExp{var,escape,lo,hi,body,pos}) = 
            (escape := false;
             traverseExp(S.enter(env, var, (d, escape)), d, body);
             trExp lo; trExp hi)
        | trExp(A.BreakExp(_)) = ()
        | trExp(A.LetExp{decs, body, pos}) =
            traverseExp(traverseDecs(env, d, decs), d, body)
        | trExp(A.ArrayExp{typ,size,init,pos}) = (trExp size; trExp init)
    in
      trExp exp
    end

  and traverseDecs(env, d, nil) = env
    | traverseDecs(env, (d, f), A.FunctionDec(fundecs) :: decs) = 
        let 
          fun procFundec({name, params, result, body, pos}) = 
            let 
              fun accParams({name=name',escape=escape,typ=typ,pos=pos}, acc) = 
                (escape := false ; S.enter(acc, name', ((d+1, name), escape)))
              val withParams = foldl accParams env params
            in
              traverseExp(withParams, (d+1, name), body)
            end
        in
          (List.app procFundec fundecs; traverseDecs(env, (d, f), decs))
        end
    | traverseDecs(env, d, A.VarDec{name, escape, typ, init, pos} :: decs) = 
        (traverseExp(env, d, init); 
         escape := false; 
         traverseDecs(S.enter(env, name, (d, escape)), d, decs))
    | traverseDecs(env, d, A.TypeDec(typedecs) :: decs) = 
        traverseDecs(env, d, decs) (* don't care *)

  fun prog(prog: Absyn.exp): unit = traverseExp(S.empty, (0, Symbol.symbol "Top"), prog)
end
