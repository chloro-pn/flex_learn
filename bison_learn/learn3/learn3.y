/* 类型表达式的语法 */
%{
  #include <stdio.h>
  #include <stdlib.h>
  int yylex();
  void yyerror(const char*);
%}

%token ID INT CHAR STRING BOOL NUM ARROW
%type type basetype arraytype functype pointertype

%%

stmtlist : 
         | stmtlist stmt
         ;

stmt : type ';'
     ;

type : basetype      { printf("base type \n");}
     | arraytype     { printf("array type \n");}
     | pointertype   { printf("pointer type \n");}
     | functype      { printf("func type \n");}
     ;

basetype : INT
         | CHAR
         | STRING
         | BOOL
         | ID
         ;

arraytype : type '[' ID ']'
          | type '[' NUM ']'
          ;

pointertype : type '*'
            ;

functype :  type '(' typelist ')'
         ;

typelist :
         | type
         | type ',' typelist
         ;

%%


void yyerror(const char* s) {
  fprintf(stderr, "%s\n", s);
}

int main() {
  yyparse();
  return 0;
}
