/* 关于 return
 * 在第二部分的动作中可以使用return返回对应记号，通过调用yylex读取小部分输入
 * 然后返回，再次调用yylex时返回下一个记号。
 */

/* 关于编号和记号值
 * 当flex返回一个记号流的时候，每个记号实际上有两个组成部分，记号编号和记号值
 * 记号编号是一个小整数，0是文件结束，bison自动从258起指派每个记号编号。
 * 记号值可以区分一组相似的记号。
 */

/**/
%{
  /*
  enum yytokentype {
    NUMBER = 258,
    ADD = 259,
    SUB = 260,
    MUL = 261,
    DIV = 262,
    ABS = 263,
    EOL = 264
  };
  int yylval;
  */
  # include "learn1.tab.h"
%}

%%
"+" {return ADD;}
"-" {return SUB;}
"*" {return MUL;}
"/" {return DIV;}
"|" {return ABS;}
"(" {return OP;}
")" {return CP;}
"//".*
[0-9]+ {yylval = atoi(yytext); return NUMBER;}
\n  {return EOL;}
[ \t] {/* 忽略， 什么都不做*/}
.   {printf("Mystery character %c\n", *yytext);}
%%


