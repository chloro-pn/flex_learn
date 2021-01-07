#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "ast.h"

struct ast_node* newop(int nodetype, struct ast_node* l, struct ast_node* r) {
  struct op_node* a = new op_node;
  if(!a) {
    yyerror("out of space");
    exit(1);
  }
  a->nodetype = nodetype;
  a->l = l;
  a->r = r;
  return a;
}

struct ast_node* newnum(double d) {
  struct numval* a = new numval;
  if(!a) {
    yyerror("out of space");
    exit(1);
  }
  a->nodetype = 'K';
  a->number = d;
  return a;
}

double eval(struct ast_node* an) {
  double v;
  op_node* a = static_cast<op_node*>(an);
  switch(an->nodetype) {
    case 'K' : v = static_cast<numval*>(an)->number; break;
    case '+' : v = eval(a->l) + eval(a->r); break;
    case '-' : v = eval(a->l) - eval(a->r); break;
    case '*' : v = eval(a->l) * eval(a->r); break;
    case '/' : v = eval(a->l) / eval(a->r); break;
    case '|' : v = eval(a->l); if(v < 0) v = -v; break;
    case 'M' : v = -eval(a->l); break;
    default : printf("internal error : bad node %c\n", a->nodetype);
  }
  return v;
}

void treefree(struct ast_node* an) {
  op_node* a = static_cast<op_node*>(an);
  switch(an->nodetype) {
    case '+' : 
    case '-' :
    case '*' :
    case '/' :
      treefree(a->r);
    case '|' :
    case 'M' :
      treefree(a->l);
    case 'K' : 
      free(static_cast<numval*>(an));
      break;
    default : printf("interval error : free bad node %c\n", a->nodetype);
  }
}

void yyerror(const char* s, ...) {
  va_list ap;
  va_start(ap, s);
  fprintf(stderr, "%d : error: ", yylineno);
  vfprintf(stderr, s, ap);
  fprintf(stderr, "\n");
}

 int yyparse();

int main() {
  printf("> ");
  int ret = yyparse();
  if(ret != 0) {
    fprintf(stderr, "sth error.\n");
    return 1;
  }
  return 0;
}
