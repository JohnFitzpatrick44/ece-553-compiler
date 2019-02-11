Lexical Analysis for the Tiger Language by Jack Fitzpatrick (jcf44) and Inchan Hwang (ih33)

Written in SML/NJ using ML-Lex.

Comment Handling
- Comments were treated as nested. /* /* */ would be considered as an open comment.
- A special comment state was used when the lexer was parsing through a comment.
- Comments are implemented by pushing yypos onto a global ref list when a "/*" is encountered, and the lexer enters a comment state.
	- When a "*/" is encountered, a value is popped off.
	- If the list is empty, the lexer returns to the initial state.
	- This allows for better detection of open comment positions.

String Handling
- Implemented much like comments, with a special string state when encountering a ".
- Global refs were used to track the initial string position and its contents.
	- When a valid character or escape sequence was encountered, it was appended to the global string ref.
	- Valid escapes were added with String.str(chr( ... ))

Error Handling
- At EOF, an error is thrown if a string or comment is still open (tracked by global refs).
- If an identifier did not start with a letter (e.g. 123abc or _abc123), it was seen as invalid, and an error is thrown.
- If a newline or illegal escape is detected in a string, an error is thrown.
- If the lexer can find no matches, an error is thrown.

End of File Handling
- At the EOF, an eof function is called.
	- This checks for open strings or comments.
	- It returns an EOF token.
