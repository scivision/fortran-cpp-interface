#include <cstring>
#include <cstdlib>

struct params {
  // order and lengths must match in Fortran and C
  int my_int;
  bool my_bool;
  char my_char[1000];
};

extern "C" void struct_check(struct params *);

int main() {

struct params s;

s.my_int = 123;
s.my_bool = true;
strcpy(s.my_char, "Hello");

struct_check(&s);

return EXIT_SUCCESS;

}
