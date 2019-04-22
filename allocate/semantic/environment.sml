functor Env(Tr: TRANSLATE) :> Environment
where 
			type access = Tr.access and
			type level = Tr.level	= 

struct

	type access = Tr.access
  type level = Tr.level

  datatype enventry = VarEntry of {access: Tr.access, ty: Types.ty, isLoopVar: bool}
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
        (Symbol.symbol("print"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "print", formals = [Types.STRING], result = Types.UNIT}), 
        (Symbol.symbol("flush"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "flush", formals = nil, result = Types.UNIT}),
        (Symbol.symbol("getchar"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "getchar", formals = nil, result = Types.STRING}),
        (Symbol.symbol("ord"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "ord", formals = [Types.STRING], result = Types.INT}),
        (Symbol.symbol("chr"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "chr", formals = [Types.INT], result = Types.STRING}),
        (Symbol.symbol("size"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "size", formals = [Types.STRING], result = Types.INT}),
        (Symbol.symbol("substring"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "substring", formals = [Types.STRING, Types.INT, Types.INT], result = Types.STRING}),
        (Symbol.symbol("concat"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "concat", formals = [Types.STRING, Types.STRING], result = Types.STRING}),
        (Symbol.symbol("not"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "not", formals = [Types.INT], result = Types.INT}),
        (Symbol.symbol("exit"), FunEntry{level=Tr.outermost, label=Temp.namedlabel "exit", formals = [Types.INT], result = Types.UNIT})
     ]
    in
      foldl (fn ((sym, entry), acc) => Symbol.enter(acc, sym, entry)) Symbol.empty base_vars
    end
end
