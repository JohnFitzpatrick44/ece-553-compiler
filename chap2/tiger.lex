type pos = int;
type lexresult = Tokens.token;

val lineNum = ErrorMsg.lineNum;
val linePos = ErrorMsg.linePos;
fun err(p1,p2) = ErrorMsg.error p1;
val commentCount = ref 0;
  
fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end;

%%

%s COMMENT_STATE;

%%

[\ \t]+ => (lex());
    
\/\* => (
    commentCount := !commentCount+1;
    YYBEGIN COMMENT_STATE;
    lex()
);

<COMMENT_STATE> \*\/ => (
    commentCount := !commentCount-1;
    if (!commentCount) = 0 then YYBEGIN INITIAL else ();
    lex()
);

<COMMENT_STATE> . => (lex());

\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
<INITIAL> ","	=> (Tokens.COMMA(yypos,yypos+1));
<INITIAL> var  	=> (Tokens.VAR(yypos,yypos+3));
<INITIAL> "123"	=> (Tokens.INT(123,yypos,yypos+3));
<INITIAL> . => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

