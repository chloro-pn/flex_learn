/* 默认输出：flex默认执行一条规则：所有没有被匹配的输入
 * 都拷贝到yyout : 
 * . ECHO;
 * #define ECHO fwrite(yytext, yyleng, 1, yyout)
 * 可以通过设置%option nodefault不添加默认规则。
 */

/* 特殊模式<<EOF>> 匹配文件结束 */

/* flex提供了一个叫做yylineno的变量记录行号,更新要自己更新 */
%option nodefault
/* 起始状态
 * 动态指定特定的模式匹配
 * flex本身定义INITIAL。
 * %x 独占， %s 包含
 */

%x IFILE

%%


^"#"[ \t]*include[ \t]*[\"<] {BEGIN IFILE;}
<IFILE>[^ \t\n\">]+  					{
															  int c;
																while((c = input()) && c != '\n');
																printf("include file : %s\n", yytext);
																++yylineno;
																BEGIN INITIAL;
													    }
<IFILE>.|\n                   {
															  fprintf(stderr, "bad include line\n");
																yyterminate();
															}
^.                         {printf("line : %d -> .", yylineno);}
.                          {printf(".");}
\n                         {printf("\n"); ++yylineno;}
<<EOF>>                    {printf("end of file!\n"); yyterminate();}
%%

int main(int argc, char** argv) {
	if(argc < 2) {
    fprintf(stderr, "need filename\n");
	  return 1;
	}
	yyin = fopen(argv[1], "r");
	yylex();
	return 0;
}
	
