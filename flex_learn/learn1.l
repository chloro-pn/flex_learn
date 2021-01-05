/*字数统计*/
/* flex包含三部分，之间用仅有%%的行来分割，每个部分分别的作用是:
 * 1. 声明和选项设置
 * 2. 一系列的模式和动作
 * 3. 会被拷贝的c代码
 */

/* 第一部分中，%{和%}之间的代码会被原样拷贝到生成的c文件的开头部分。*/

%{
  int chars = 0;
  int words = 0;
  int lines = 0;
%}

/* 第二部分，每个模式在一行的开头处，接着是模式匹配时所执行的c代码（用{}括住的一行或多行语句。）
 * 模式必须在行首出现，以空白开始的行都会被认为是代码
 */

/* 关于yytext
 * yytext是flex提供的变量，这个变量是指向本次匹配的输入字符串的指针。
 */

/* 在模式部分可以使用双引号引起， 告诉flex使用引号内文本的原义，而不解释成正则表达式。*/

%%

"quit" { printf("got it!\n"); }
"test" { printf("valid!\n"); }
[^ \t\n\r\f\v]+ {words++; chars += strlen(yytext);}
\n        {chars++; lines++;}
.         {chars++;}

%%

/* yylex()是flex提供的词法分析历程， 默认从标准输入读取。*/
int main(int argc, char** argv) {
  yylex();
  printf("%8d%8d%8d\n", lines, words, chars);
  return 0;
}
