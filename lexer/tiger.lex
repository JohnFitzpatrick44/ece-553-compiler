type pos = int;
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos

val partialString = ref ""
val stringStartPos = ref ~1

val commentCount = ref 0

fun eof() = let val pos = hd(!linePos)
	    in
			(if !stringStartPos >= 0 then ErrorMsg.error !stringStartPos (" open string at end of file") else ());
			Tokens.EOF(pos,pos)
	    end
%%
%s COMMENT_STATE, STRING_STATE;
escapeDigits = ([0-1][0-9][0-9])|(2[0-4][0-9])|(25[0-5]);
%%

\/\* => (
    commentCount := !commentCount+1;
    YYBEGIN COMMENT_STATE;
    continue()
);

<COMMENT_STATE>\*\/ => (
    commentCount := !commentCount-1;
    if (!commentCount) = 0 then YYBEGIN INITIAL else ();
    continue()
);

<COMMENT_STATE>[^\n] 	=> (continue());
\n	=> (
    lineNum := !lineNum+1;
    linePos := yypos :: !linePos;
    continue()
);

<INITIAL>[ \t]+	=> (continue());
<INITIAL>"type" 	=> (Tokens.TYPE(yypos,yypos+4));
<INITIAL>"var"		=> (Tokens.VAR(yypos,yypos+3));
<INITIAL>"function"	=> (Tokens.FUNCTION(yypos,yypos+8));
<INITIAL>"break"	=> (Tokens.BREAK(yypos,yypos+5));
<INITIAL>"of"		=> (Tokens.OF(yypos,yypos+2));
<INITIAL>"end"		=> (Tokens.END(yypos,yypos+3));
<INITIAL>"in"		=> (Tokens.IN(yypos,yypos+2));
<INITIAL>"nil"		=> (Tokens.NIL(yypos,yypos+3));
<INITIAL>"let" 		=> (Tokens.LET(yypos,yypos+3));
<INITIAL>"do"		=> (Tokens.DO(yypos,yypos+2));
<INITIAL>"to" 		=> (Tokens.TO(yypos,yypos+2));
<INITIAL>"for" 		=> (Tokens.FOR(yypos,yypos+3));
<INITIAL>"while" 	=> (Tokens.WHILE(yypos,yypos+5));
<INITIAL>"else" 	=> (Tokens.ELSE(yypos,yypos+4));
<INITIAL>"then" 	=> (Tokens.THEN(yypos,yypos+4));
<INITIAL>"if" 		=> (Tokens.IF(yypos,yypos+2));
<INITIAL>"array" 	=> (Tokens.ARRAY(yypos,yypos+5));
<INITIAL>":="	    => (Tokens.ASSIGN(yypos,yypos+6));
<INITIAL>"|"		=> (Tokens.OR(yypos,yypos+1));
<INITIAL>"&"		=> (Tokens.AND(yypos,yypos+1));
<INITIAL>">="		=> (Tokens.GE(yypos,yypos+2));
<INITIAL>">" 		=> (Tokens.GT(yypos,yypos+1));
<INITIAL>"<="		=> (Tokens.LE(yypos,yypos+2));
<INITIAL>"<"		=> (Tokens.LT(yypos,yypos+1));
<INITIAL>"<>"		=> (Tokens.NEQ(yypos,yypos+2));
<INITIAL>"="		=> (Tokens.EQ(yypos,yypos+1));
<INITIAL>"/"		=> (Tokens.DIVIDE(yypos,yypos+1));
<INITIAL>"*"		=> (Tokens.TIMES(yypos,yypos+1));
<INITIAL>"-" 		=> (Tokens.MINUS(yypos,yypos+1));
<INITIAL>"+"		=> (Tokens.PLUS(yypos,yypos+1));
<INITIAL>"."		=> (Tokens.DOT(yypos,yypos+1));
<INITIAL>"}"		=> (Tokens.RBRACE(yypos,yypos+1));
<INITIAL>"{"		=> (Tokens.LBRACE(yypos,yypos+1));
<INITIAL>"]"		=> (Tokens.RBRACK(yypos,yypos+1));
<INITIAL>"["		=> (Tokens.LBRACK(yypos,yypos+1));
<INITIAL>")"		=> (Tokens.RPAREN(yypos,yypos+1));
<INITIAL>"("		=> (Tokens.LPAREN(yypos,yypos+1));
<INITIAL>";"		=> (Tokens.SEMICOLON(yypos,yypos+1));
<INITIAL>":"		=> (Tokens.COLON(yypos,yypos+1));
<INITIAL>","		=> (Tokens.COMMA(yypos,yypos+1));
<INITIAL>[0-9]+		=> (Tokens.INT(valOf (Int.fromString yytext),yypos,yypos+String.size(yytext)));
<INITIAL>[A-Za-z][A-Za-z0-9_]* => (Tokens.ID(yytext,yypos,yypos+String.size(yytext)));

<INITIAL>\"			=> (YYBEGIN STRING_STATE; partialString := ""; stringStartPos := yypos; continue());
<STRING_STATE>\"	=> (	YYBEGIN INITIAL; 
							val result = !partialString; 
							val pos = !stringStartPos; 
							partialString := ""; 
							stringStartPos := ~1; 
							Tokens.STRING(result, pos, yypos+1)
						); 
<STRING_STATE>\\[\\\"nt]	=> ();
<STRING_STATE>\\{escapeDigits}	=> ();
<STRING_STATE>\\.			=> (ErrorMsg.error yypos (" illegal escape character " ^ yytext); continue());
<STRING_STATE>.				=> (partialString := !partialString ^ yytext; continue());

<INITIAL>. => (ErrorMsg.error yypos ("Failed parsing " ^ yytext); continue());
