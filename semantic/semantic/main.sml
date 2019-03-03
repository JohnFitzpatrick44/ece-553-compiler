structure Main = 
struct
  fun compile(filename: string): unit = let
    val absyn = Parse.parse filename
    val () = PrintAbsyn.print(TextIO.stdOut, absyn)
  in
    Semant.transProg absyn
  end
end
