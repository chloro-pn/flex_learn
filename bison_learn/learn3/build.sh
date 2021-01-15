bison -d learn3.y -r all -x
flex learn3.l
g++ lex.yy.c learn3.tab.c type_set.cpp 
