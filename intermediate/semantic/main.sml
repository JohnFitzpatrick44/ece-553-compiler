structure Main = 
struct
  fun compile(filename: string): unit = let
    val absyn = Parse.parse filename
    val () = FindEscape.findEscape(absyn)
    val () = print "\n\n---------AST---------\n"
    val () = PrintAbsyn.print(TextIO.stdOut, absyn)
    val () = Semant.transProg absyn
    val () = print "\n\n-------FRAGMENTS------\n"
    val () = Translate.printResult TextIO.stdOut
  in
    ()
  end
end
