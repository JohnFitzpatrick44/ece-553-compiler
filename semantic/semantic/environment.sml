structure Env =
struct
  type access = unit (* ??? *)
  type ty = Types.ty
  datatype enventry = VarEntry of {ty: ty}
                    | FunEntry of {formals: ty list, result: ty}

  val base_tenv: ty Symbol.table = Symbol.empty (* for now *)
  val base_venv: enventry Symbol.table = Symbol.empty (* for now *)
end
