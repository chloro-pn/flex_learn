bison -d learn2.y
flex learn2.l
cc learn2.tab.c lex.yy.c ast.c
