%option noyywrap nodefault yylineno

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "learn3.tab.h"
%}

%%

";" |
"!" |
"(" |
")" |
"[" |
"]" |
"*" |
"," { return yytext[0]; }
char { return CHAR; }
int { return INT; }
string { return STRING; }
true |
false {return BOOL; }
[1-9][0-9]* {return NUM; }
-> { return ARROW; }
[a-zA-Z_][0-9a-zA-Z]* { return ID; }
[ \t]
. 
\n

%%

