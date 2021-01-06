/* 基于抽象语法树的计算器 */

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "ast.h"
%}

/* 每一个语法符号，包括终结符和非终结符，都可以有一个
 * 相应的值，默认情况下都是整数，但可以通过联合类型来
 * 为不同的语法符号指定不同的值类型
 */

%union {
  struct ast_node* a;
  double d;
}

%token <d> NUMBER
%token EOL EXIT
%type <a> exp factor term

/* literal character
 * 单引号引起的字符可以作为记号，记号的ASCII值将成为记号的编号
 */
%%

calclist:
        | calclist exp EOL {
                             printf("= %4.4g\n", eval($2));
                             treefree($2);
                             printf("> ");
                           }
        | calclist EOL { printf("> "); }
        ;

exp : factor
    | exp '+' factor { $$ = newop('+', $1, $3); }
    | exp '-' factor { $$ = newop('-', $1, $3); }
    | EXIT { YYACCEPT; }
    ;

factor : term
       | factor '*' term { $$ = newop('*', $1, $3); }
       | factor '/' term { $$ = newop('/', $1, $3); }
       ;

term : NUMBER { $$ = newnum($1); }
     | '|' term { $$ = newop('|', $2, NULL); }
     | '(' exp ')' { $$ = $2; }
     | '-' term { $$ = newop('M', $2, NULL); }
     ;
%%
