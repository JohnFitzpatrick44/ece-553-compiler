structure Env :> Environment =
struct
  structure Tr = Translate

  datatype enventry = VarEntry of {access: Tr.access, ty: Types.ty}
                    | FunEntry of {level: Tr.level, label: Temp.label, formals: Types.ty list, result: Types.ty}

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
        (Symbol.symbol("print"), FunEntry{Tr.outermost, Temp.namedLabel "print", formals = [Types.STRING], result = Types.UNIT}), 
        (Symbol.symbol("flush"), FunEntry{Tr.outermost, Temp.namedLabel "flush", formals = nil, result = Types.UNIT}),
        (Symbol.symbol("getchar"), FunEntry{Tr.outermost, Temp.namedLabel "getchar", formals = nil, result = Types.STRING}),
        (Symbol.symbol("ord"), FunEntry{Tr.outermost, Temp.namedLabel "ord", formals = [Types.STRING], result = Types.INT}),
        (Symbol.symbol("chr"), FunEntry{Tr.outermost, Temp.namedLabel "chr", formals = [Types.INT], result = Types.STRING}),
        (Symbol.symbol("size"), FunEntry{Tr.outermost, Temp.namedLabel "size", formals = [Types.STRING], result = Types.INT}),
        (Symbol.symbol("substring"), FunEntry{Tr.outermost, Temp.namedLabel "substring", formals = [Types.STRING, Types.INT, Types.INT], result = Types.STRING}),
        (Symbol.symbol("concat"), FunEntry{Tr.outermost, Temp.namedLabel "concat", formals = [Types.STRING, Types.STRING], result = Types.STRING}),
        (Symbol.symbol("not"), FunEntry{Tr.outermost, Temp.namedLabel "not", formals = [Types.INT], result = Types.INT}),
        (Symbol.symbol("exit"), FunEntry{Tr.outermost, Temp.namedLabel "exit", formals = [Types.INT], result = Types.UNIT})
     ]
    in
      foldl (fn ((sym, entry), acc) => Symbol.enter(acc, sym, entry)) Symbol.empty base_vars
    end
end
