signature TRANSLATE =
sig

type exp
type level
type access
type frag

val outermost: level
val newLevel : {parent: level, name: Temp.label, formals: bool list} -> level
val formals: level -> access list
val allocLocal: level -> bool -> access
val procEntryExit: {level:level, body:exp} -> unit
val getResult : unit -> frag list



(* Variable declarations *)
val simpleVar: access * level -> exp
val subscriptVar: exp * exp -> exp
val fieldVar: exp * int -> exp



(* Expressions *)
val binop: Absyn.oper * exp * exp -> exp 
val relop: Absyn.oper * exp * exp -> exp
val ifThenExp: exp * exp -> exp
val ifThenElseExp: exp * exp * exp -> exp
val assignExp: exp * exp -> exp
val breakExp: Temp.label -> exp
val seqExp: exp list -> exp
val letExp: exp list * exp -> exp
val whileExp: exp * exp * Temp.label -> exp
val forExp: exp * exp * exp * exp * Temp.label -> exp
val recordExp: exp list -> exp
val arrayExp: exp * exp -> exp
val callExp : Temp.label * level * level * exp list -> exp



(* Literals *)
val intLit: int -> exp
val nilLit: unit -> exp
val strLit: string -> exp

val stringEQ:  exp * exp -> exp
val stringNEQ:  exp * exp -> exp

end