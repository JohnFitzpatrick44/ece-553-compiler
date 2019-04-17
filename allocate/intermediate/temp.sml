structure Temp : TEMP =
struct
    type temp = int
    val temps = ref 100
    fun newtemp() = let val t = !temps in temps := t+1; t end


		val compare = Int.compare

    fun makestring t = "t" ^ Int.toString t

	  type label = Symbol.symbol

    fun labelCompare(s1, s2) = Int.compare(Symbol.id s1, Symbol.id s2)

    structure LabelOrd =
    struct 
      type ord_key = label
      val compare = labelCompare
    end

		structure TempOrd =
    struct
      type ord_key = temp
      val compare = Int.compare
    end

    structure Set = SplaySetFn(TempOrd)
    structure Map = SplayMapFn(TempOrd)
    structure Table = IntMapTable(type key = int
                                  fun getInt n = n)

		local structure F = Format
      fun postinc x = let val i = !x in x := i+1; i end
      val labs = ref 0
 		in
   	 	fun newlabel() = Symbol.symbol(F.format "L%d" [F.INT(postinc labs)])
    	val namedlabel = Symbol.symbol
			val labelString = Symbol.name
			fun reset () = (temps:=100 ; labs:=0)
		end
end
