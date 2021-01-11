%option noyywrap nodefault yylineno

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "learn3.tab.h"
  
  enum class lastToken {
    TYPE,
    FUNC,
    OTHER,
    NONE,
  };

  lastToken last_token = lastToken::NONE;
%}

%%

";" |
"!" |
"(" |
")" |
"[" |
"]" |
"+" |
"-" |
"*" |
"/" |
"{" |
"}" |
"," { return yytext[0]; }
char { return CHAR; }
'[a-zA-Z]' { return CHAR_LITERAL; }
int { return INT; }
[1-9][0-9]* {return NUM_LITERAL; }
string { return STRING; }
\".*\" { return STR_LITERAL; }
bool  {return BOOL; }
true { return TRUE; }
false { return FALSE; }
for { return FOR; }
if { return IF; }
while { return WHILE; }
else { return ELSE; }
func { return FUNC; }
type { last_token = lastToken::TYPE; return TYPE; }
[a-zA-Z_][0-9a-zA-Z]* {
                        if(last_token == lastToken::TYPE) {
                          last_token = lastToken::NONE;
                          return TYPE_TOKEN;
                        }
                        return ID;
                      }
[ \t]
. 
\n

%%

