#include "type_set.h"

std::unordered_set<std::string> types;

class type_set_init_ {
  public:
    type_set_init_() {
      types.insert("int");
      types.insert("string");
      types.insert("char");
      types.insert("bool");
    }
}

static type_set_init_;
