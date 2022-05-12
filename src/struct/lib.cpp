#include <iostream>
#include <cstring>
#include <cstdlib>

#include "my_struct.h"

void struct_check(struct params *s) {

struct params *p = s;

if (p->my_int != 123) {
  std::cerr << "Error: my_int = " << p->my_int << std::endl;
  exit(EXIT_FAILURE);
}

if (! p->my_bool) {
  std::cerr << "Error: my_bool is false" << std::endl;
  exit(EXIT_FAILURE);
}

if (strncmp(p->my_char, "Hello", 5) != 0) {
  std::cerr << "Error: my_char != Hello " << p->my_char << std::endl;
  exit(EXIT_FAILURE);
}

}
