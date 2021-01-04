/* 正则表达式

.      匹配除了换行符以外的任意单一字符。
[]     character class，可以匹配方括号中的任意一个字符。
       如果第一个字符是^，则匹配除了方括号以内字符以外的任何字符。
       内部的-表示字符范围：0-9， a-z, A-Z。可以把-作为第一个字符放在[之后，这样字符类也包含它。
       以\开头的转义序列在[]中也会被识别，其他元字符则没有特殊含义。
^      如果是正则表达式的第一个字符就匹配行首。
$      如果是最后一个字符则匹配行尾。
\      转义，元字符可以通过它表示自身。也可以用来表示常用的c语言转义序列：\n
*      0个或多个
+      1个或多个
？     0个或1个
{}     表示前一个模式可以匹配的最小和最大的次数，另一个用法是内部带有名字，则指向以这个名字命名的模式
|      选择
"..."  引号中的字符将基于字面意义被解释
()     组合
/      尾部上下文，匹配/前的正则表达式，但是要求其后面紧跟着/后的表达式

*/

/* 处理二以性模式
 * 1. 匹配尽可能多的字符串
 * 2. 匹配在程序中更早出现的模式
 */

/* 上下文相关
 * flex提供了起始状态的概念，动态开启和关闭特定模式。
 */

/* 文件io
 * 默认flex从标准输入读取，可以在调用yylex之前重新设定yyin(FILE*)从文件中读取。
 */

/* input() and unput()
 * 向前看，放回
 */

/* yywrap是一个回调函数，当flex到达yyin的结束位置时，会调用yywrap()。当有另外一个输入文件时，
 * yywrap可以调整yyin的值并通过返回0来重新开始词法分析。返回1则真正结束。
 * 通过设置%option noyywrap来禁用这个功能，使用其他的io管理特性。
 */
%option noyywrap

%{
  int chars = 0;
  int words = 0;
  int lines = 0;
%}

%%

helloworld      {printf("hello world\n");}
hello           {printf("hello\n");}
1               {
                  int c = input();
                  if(c != 0 && c == '2') {
                    printf("12!\n");
                  }
                  else {
                    printf("1 without 2!\n");
                  }
                  unput(c); 
                }
[a-zA-Z]+ {words++; chars += strlen(yytext);}
\n        {chars++; lines++;}
.         {chars++;}

%%

int main(int argc, char** argv) {
  int i;
  if(argc <  2) {
    yylex();
    printf("%8d%8d%8d\n", lines, words, chars);
    return 0;
  }

  for(i = 1; i < argc; ++i) {
    FILE* f = fopen(argv[i], "r");

    if(!f) {
      perror(argv[i]);
      return 1;
    }
/* 通过使用yyrestart重新打开文件并继续读取*/
    yyrestart(f);
    yylex();
    fclose(f);
    printf("%8d%8d%8d %s\n", lines, words, chars, argv[i]);
    chars = 0;
    words = 0;
    lines = 0;
  }
  return 0; 
}
