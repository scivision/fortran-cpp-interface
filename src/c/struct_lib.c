#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

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
  fprintf(stderr, "Error: my_int = %d\n", s.my_int);
  exit(EXIT_FAILURE);
}

if (! s.my_bool) {
  fprintf(stderr, "Error: my_bool is false\n");
  exit(EXIT_FAILURE);
}

if (s.Lmy_char != 5) {
  fprintf(stderr, "Error: my_char wrong length %d\n", s.Lmy_char);
  exit(EXIT_FAILURE);
}

if (strcmp(s.my_char, "Hello") != 0) {
  fprintf(stderr, "Error: my_char != Hello: %s\n", s.my_char);
  exit(EXIT_FAILURE);
}

}
