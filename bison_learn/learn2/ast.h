#include <vector>
#include <string>

/* flex 提供  */
extern int yylineno;

/* 需要自己实现，在tab.c中 */
void yyerror(const char* s, ...);

/* flex提供 */
int yylex();

struct ast_node {
  int nodetype;
};

struct op_node : public ast_node {
  struct ast_node* l;
  struct ast_node* r;
};

struct numval : public ast_node {
  double number;
};

struct ast_node* newop(int nodetype, struct ast_node* l, struct ast_node* r);
struct ast_node* newnum(double d);

double eval(struct ast_node*);

void treefree(struct ast_node*);

