#include <iostream>
#include <cstring>
#include <cstdlib>

struct params {
  // order and lengths must match in Fortran and C
  int my_int;
  bool my_bool;
  int Lmy_char;
  char my_char[1000];
};

void struct_check(struct params);

void struct_check(struct params s) {

if (s.my_int != 123) {
  std::cerr << "Error: my_int = " << s.my_int << std::endl;
  exit(EXIT_FAILURE);
}

if (! s.my_bool) {
  std::cerr << "Error: my_bool is false" << std::endl;
  exit(EXIT_FAILURE);
}

if (s.Lmy_char != 5) {
  std::cerr << "Error: my_char wrong length " << s.Lmy_char << std::endl;
  exit(EXIT_FAILURE);
}

}
