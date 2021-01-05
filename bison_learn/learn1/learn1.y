%{
  #include <stdio.h>
%}
/* 记号值存储在yyval中 */

/* 为空的规则不进行任何匹配 */
/* 联合使用flex和bison
 * flex使用bison生成的头文件而不定义显式的记号值，
 * bison生成的头文件中包含了记号编号的定义和yylval的定义。
 * 同时要删除flex第三部分的主例程
 */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP

%%

calclist: /* 空规则 */
        | calclist exp EOL {printf(" = %d\n", $2);}
        ;

exp: factor
   | exp ADD factor {$$ = $1 + $3;}
   | exp SUB factor {$$ = $1 - $3;}
   ;

factor: term
      | factor MUL term {$$ = $1 * $3;}
      | factor DIV term {$$ = $1 / $3;}
      ;

term: NUMBER
    | ABS term {$$ = $2 >= 0?$2 : -$2;}
    | OP exp CP {$$ = $2;}
    ;

%%

int main() {
  yyparse();
}

void yyerror(char* s) {
  fprintf(stderr, "error: %s\n", s);
}
