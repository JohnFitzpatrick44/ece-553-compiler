structure Types =
struct

  type unique = unit ref

  datatype ty = 
            RECORD of (Symbol.symbol * ty) list * unique
          | NIL
          | INT
          | STRING
          | ARRAY of ty * int * unique
	        | NAME of Symbol.symbol * ty option ref
	        | UNIT
          | BOT

  fun eq(RECORD(_, r1), RECORD(_, r2)) = r1 = r2
    | eq(RECORD(_, _), NIL) = true
    | eq(NIL, RECORD(_, _)) = true
    | eq(NIL, NIL) = true
    | eq(INT, INT) = true
    | eq(STRING, STRING) = true
    | eq(ARRAY(_, _, r1), ARRAY(_, _, r2)) = r1 = r2
    | eq(NAME(s1, _), NAME(s2, _)) = (Symbol.id s1) = (Symbol.id s2)
    | eq(UNIT, UNIT) = true
    | eq(_, BOT) = true
    | eq(BOT, _) = true
    | eq(_, _) = false
end

