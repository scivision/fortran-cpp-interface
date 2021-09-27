#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

enum { Lchar = 1000 };

struct params {
  // order and lengths must match in Fortran and C
  int my_int;
  bool my_bool;
  char my_char[Lchar];
};

extern void struct_check(struct params *);

int main(void) {

struct params s;

s.my_int = 123;
s.my_bool = true;
strcpy(s.my_char, "Hello");

struct_check(&s);

return EXIT_SUCCESS;

}
