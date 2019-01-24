type pos = int;
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos

val partialString = ref ""
val stringStartPos = ref ~1

val commentCount = ref 0

fun getEscapedChar c =
	case c of
		  "\\^@" => Char.toString(chr(0))
		| "\\^G" => Char.toString(chr(7))
		| "\\^H" => Char.toString(chr(8))
		| "\\^I" => Char.toString(chr(9))
		| "\\^J" => Char.toString(chr(10))
		| "\\^K" => Char.toString(chr(11))
		| "\\^L" => Char.toString(chr(12))
		| "\\^M" => Char.toString(chr(13))
		| "\\^Z" => Char.toString(chr(26))
		| "\\^[" => Char.toString(chr(27))
		| "\\n"  => Char.toString(chr(10))
		| "\\t"  => Char.toString(chr(9))
		| "\\\"" => Char.toString(chr(34))
		| "\\"	 => Char.toString(chr(92))
		| a => a

fun eof() = let val pos = hd(!linePos)
	    in
			(if (!stringStartPos) >= 0 then ErrorMsg.error (!stringStartPos) (" open string at end of file") else ());
			(if (!commentCount) > 0 then ErrorMsg.error pos (" open comment at end of file") else ());
			Tokens.EOF(pos,pos)
	    end
%%
%s COMMENT_STATE STRING_STATE;
escapeDigits = ([0-1][0-9][0-9])|(2[0-4][0-9])|(25[0-5]);
%%
<INITIAL>[\ \t]+	=> (continue());
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


<INITIAL>\/\* => (
    commentCount := (!commentCount)+1;
    YYBEGIN COMMENT_STATE;
    continue()
);
<COMMENT_STATE>\/\* => (
    commentCount := (!commentCount)+1;
    continue()
);
<COMMENT_STATE>\*\/ => (
    commentCount := (!commentCount)-1;
    if (!commentCount) = 0 then YYBEGIN INITIAL else ();
    continue()
);
<COMMENT_STATE>[^\n] 	=> (continue());


<INITIAL>\"			=> (YYBEGIN STRING_STATE; partialString := ""; stringStartPos := yypos; continue());
<STRING_STATE>\"	=> (	YYBEGIN INITIAL; 
							let val result = (!partialString) 
								val pos = (!stringStartPos)
							in 
								partialString := ""; 
								stringStartPos := ~1; 
								Tokens.STRING(result, pos, yypos+1)
							end
						); 

<STRING_STATE>\\(([\\\"nt])|("^"[@GHIJKLMZ\[]))	=> (partialString := (!partialString) ^ (getEscapedChar yytext); continue());
<STRING_STATE>\\{escapeDigits}	=> (partialString := (!partialString) ^ (Char.toString(chr(valOf (Int.fromString (String.substring(yytext,1,3)))))); continue());
<STRING_STATE>\\[\s]+\\		=> (continue());
<STRING_STATE>\\.			=> (ErrorMsg.error yypos (" illegal escape character " ^ yytext); continue());
<STRING_STATE>.				=> (partialString := (!partialString) ^ yytext; continue());
<STRING_STATE>\n 	=> (ErrorMsg.error yypos ("Illegal new line in string"); continue());

\n	=> (
    lineNum := (!lineNum)+1;
    linePos := yypos :: (!linePos);
    continue()
);
. => (ErrorMsg.error yypos ("Failed parsing " ^ yytext); continue());