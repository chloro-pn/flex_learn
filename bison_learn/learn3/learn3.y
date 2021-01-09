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

stmt : var_define_stmt ';'
     ;

var_define_stmt : type ID
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

arraytype : array_type array
          ;

array_type : basetype
           | arraytype
           ;

array : '[' NUM ']'
      ;

pointertype : basetype pp
            ;
pp : '*' 
   | pp '*'
   ;

functype :  '(' typelist ')' ARROW return_type
         ;

return_type : basetype
            | pointertype
            | functype
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
