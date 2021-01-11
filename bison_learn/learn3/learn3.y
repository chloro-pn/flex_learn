/* 类型表达式的语法 */
%{
  #include <stdio.h>
  #include <stdlib.h>
  int yylex();
  void yyerror(const char*);
%}

%token ID INT CHAR STRING BOOL TYPE_TOKEN 
%token FOR WHILE IF ELSE
%token NUM_LITERAL STR_LITERAL CHAR_LITERAL TRUE FALSE
%token FUNC TYPE

%left '+' '-'
%left '*' '/'

%%

stmtlist : 
         | stmtlist stmt
         ;

stmt : type ID ';'
     | expr_stmt
     | func_define_stmt { printf(" func define\n"); }
     | type_define_stmt { printf(" type define\n"); }
     | block_stmt
     | if_stmt      { printf("if stmt\n"); }
     | while_stmt   { printf("while stmt\n"); }
     | for_stmt     { printf("for stmt\n"); }
     ;

block_stmt : '{' list '}'
           ;

list : stmt 
     | list stmt
     ;

expr : ID
     | literal
     | expr '+' expr
     | expr '-' expr
     | expr '*' expr
     | expr '/' expr
     ;

literal : NUM_LITERAL
        | STR_LITERAL
        | CHAR_LITERAL
        | TRUE
        | FALSE
        ;

expr_stmt : expr ';'
          ;

func_define_stmt : FUNC ID '(' param_list ')' block_stmt
                 ;

param_list : 
           | type ID
           | param_list ',' type ID
           ;

type_define_stmt : TYPE TYPE_TOKEN '{' member_list '}'
                 ;

member_list : type ID ';'
            | member_list type ID ';'
            ;

if_stmt : IF '(' expr ')' block_stmt else_stmt
        ;

while_stmt : WHILE '(' expr ')' block_stmt
           ;

for_stmt : FOR '(' stmt  expr ';' stmt ')' block_stmt

else_stmt :
          | ELSE block_stmt
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
         | TYPE_TOKEN
         ;

arraytype : type '[' ID ']'
          | type '[' NUM_LITERAL ']'
          | type '[' ']'
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
