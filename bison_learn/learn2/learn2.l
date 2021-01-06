%option noyywrap nodefault yylineno

%{
  #include "ast.h"
  #include "learn2.tab.h"
%}

EXP ([Ee][-+]?[0-9]+)

%%
"exit" {return EXIT; yyterminate();}
"+" |
"-" |
"*" |
"/" |
"|" |
"(" |
")" { return yytext[0]; }
[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.d = atof(yytext); return NUMBER; }

\n {return EOL;}
"//".*
[ \t]
. {yyerror("mystery character %c\n", *yytext); }
%%


