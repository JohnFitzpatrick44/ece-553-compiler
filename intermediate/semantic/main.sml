structure Main = 
struct
  fun compile(filename: string): unit = let
    val absyn = Parse.parse filename
  in
    ( 
      Translate.clear();
      FindEscape.findEscape(absyn);
      print "\n\n---------AST---------\n";
      PrintAbsyn.print(TextIO.stdOut, absyn);
      Semant.transProg absyn;
      print "\n\n-------FRAGMENTS------\n";
      Translate.printResult TextIO.stdOut 
    )
  end
end
