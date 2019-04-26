structure Log = 
struct

  type entry = int * string

  fun filteredConcat(lst: entry list, toAdd: entry list): entry list =
    let
      fun isNotInLst((p, l)): bool =
        not (List.exists (fn (p2, l2) => p = p2 andalso l = l2) lst)
    in
      List.concat [List.filter isNotInLst toAdd, lst]
    end

  datatype 'a log = LOGGED of 'a * entry list
  fun map (LOGGED(a, logs): 'a log, f: 'a -> 'b): 'b log = LOGGED(f(a), logs)
  fun flatMap (LOGGED(a, lst): 'a log, f: 'a -> 'b log): 'b log =
    case f(a) of LOGGED(b, rst) => LOGGED(b, filteredConcat(lst, rst))

  fun success(value: 'a): 'a log = LOGGED(value, [])
  fun failure(value: 'a, pos: int, msg: string): 'a log = LOGGED(value, [(pos, msg)])

  fun valueOf(LOGGED(v, _): 'a log): 'a = v
  fun logOf(LOGGED(_, l): 'a log): entry list = l

  fun all(lst: 'a log list): 'a list log =
    foldl 
      (fn (LOGGED(v, log), LOGGED(accV, accLog)) => LOGGED(v :: accV, filteredConcat(accLog, log)))
      (LOGGED([], []))
      lst

  fun pair(LOGGED(a, log1): 'a log, LOGGED(b, log2): 'b log): ('a * 'b) log = 
    LOGGED((a, b), filteredConcat(log1, log2))

  fun report(LOGGED(_, logs): 'a log): unit =
    foldr (fn ((pos, msg), acc) => ErrorMsg.error pos msg) () logs
  
  fun isLogEmpty(LOGGED(_, [])) = true
    | isLogEmpty(LOGGED(_, _)) = false
end
