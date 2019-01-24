structure Tester =
struct
fun test() =
    let val is = TextIO.openIn "test.tiger";
	val lexer = Mlex.makeLexer (fn n => TextIO.inputN(is, n));
    in
	map (fn () => lexer()) (List.tabulate(50, fn n => ()))
    end
end
