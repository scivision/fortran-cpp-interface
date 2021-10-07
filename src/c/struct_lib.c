#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "my_struct.h"


void struct_check(struct params s) {

if (s.my_int != 123) {
  fprintf(stderr, "Error: my_int = %d\n", s.my_int);
  exit(EXIT_FAILURE);
}

if (! s.my_bool) {
  fprintf(stderr, "Error: my_bool is false\n");
  exit(EXIT_FAILURE);
}

if (strncmp(s.my_char, "Hello", 5) != 0) {
  fprintf(stderr, "Error: my_char != Hello: %s\n", s.my_char);
  exit(EXIT_FAILURE);
}

}
