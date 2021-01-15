%option noyywrap nodefault yylineno

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "learn3.tab.h"
  #include "type_set.h"

  enum class TokenType {
    TYPE_TOKEN,
    FUNC_TOKEN,
    OTHER,
    NONE,
  };

  TokenType token_type = TokenType::NONE;
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
func { token_type = TokenType::FUNC_TOKEN; return FUNC; }
type { token_type = TokenType::TYPE_TOKEN; return TYPE; }
[a-zA-Z_][0-9a-zA-Z]* {
                        if(token_type == TokenType::TYPE_TOKEN) {
                          types.insert(std::string(yytext, yyleng));
                          token_type =TokenType::OTHER;
                          return TYPE_TOKEN;
                        }
                        else if(token_type == TokenType::FUNC_TOKEN) {
                          token_type = TokenType::OTHER;
                          return FUNC_TOKEN;
                        }
                        if( types.find(std::string(yytext, yyleng)) != types.end() ) {
                          return TYPE_TOKEN;
                        }
                        return ID;
                      }
[ \t]
. 
\n

%%

