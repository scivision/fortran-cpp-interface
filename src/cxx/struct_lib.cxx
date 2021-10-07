#include <iostream>
#include <cstring>
#include <cstdlib>

#include "my_struct.h"

void struct_check(struct params s) {

if (s.my_int != 123) {
  std::cerr << "Error: my_int = " << s.my_int << std::endl;
  exit(EXIT_FAILURE);
}

if (! s.my_bool) {
  std::cerr << "Error: my_bool is false" << std::endl;
  exit(EXIT_FAILURE);
}

if (strncmp(s.my_char, "Hello", 5) != 0) {
  std::cerr << "Error: my_char != Hello " << s.my_char << std::endl;
  exit(EXIT_FAILURE);
}

}
