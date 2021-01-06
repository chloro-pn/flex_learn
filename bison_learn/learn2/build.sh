bison -d learn2.y
flex learn2.l
g++ learn2.tab.c lex.yy.c ast.c -lfl -std=c++11
