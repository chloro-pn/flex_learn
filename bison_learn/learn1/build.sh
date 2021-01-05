bison -d learn1.y
flex learn2.l
cc learn1.tab.c lex.yy.c -lfl
