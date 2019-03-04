structure Env =
struct
  type access = unit (* ??? *)
  datatype enventry = VarEntry of {ty: Types.ty}
                    | FunEntry of {formals: Types.ty list, result: Types.ty}

  val base_tenv: Types.ty Symbol.table = 
    let 
      val base_types = [(Symbol.symbol("int"), Types.INT),
                        (Symbol.symbol("string"), Types.STRING)]
    in
      foldl (fn ((sym, typ), acc) => Symbol.enter(acc, sym, typ)) Symbol.empty base_types
    end

  val base_venv: enventry Symbol.table = 
    let 
      val base_vars = [
        (Symbol.symbol("print"), FunEntry{formals = [Types.STRING], result = Types.UNIT}), 
        (Symbol.symbol("flush"), FunEntry{formals = nil, result = Types.UNIT}),
        (Symbol.symbol("getchar"), FunEntry{formals = nil, result = Types.STRING}),
        (Symbol.symbol("ord"), FunEntry{formals = [Types.STRING], result = Types.INT}),
        (Symbol.symbol("chr"), FunEntry{formals = [Types.INT], result = Types.STRING}),
        (Symbol.symbol("size"), FunEntry{formals = [Types.STRING], result = Types.INT}),
        (Symbol.symbol("substring"), FunEntry{formals = [Types.STRING, Types.INT, Types.INT], result = Types.STRING}),
        (Symbol.symbol("concat"), FunEntry{formals = [Types.STRING, Types.STRING], result = Types.STRING}),
        (Symbol.symbol("not"), FunEntry{formals = [Types.INT], result = Types.INT}),
        (Symbol.symbol("exit"), FunEntry{formals = [Types.INT], result = Types.UNIT})
     ]
    in
      foldl (fn ((sym, entry), acc) => Symbol.enter(acc, sym, entry)) Symbol.empty base_vars
    end
end
