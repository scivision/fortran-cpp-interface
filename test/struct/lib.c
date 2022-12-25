#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "my_struct.h"


void struct_check(struct params *s) {

struct params *p = s;

if (p->my_int != 123) {
  fprintf(stderr, "Error: my_int = %d\n", p->my_int);
  exit(EXIT_FAILURE);
}

if (! p->my_bool) {
  fprintf(stderr, "Error: my_bool is false\n");
  exit(EXIT_FAILURE);
}

if (strncmp(p->my_char, "Hello", 5) != 0) {
  fprintf(stderr, "Error: my_char != Hello: %s\n", p->my_char);
  exit(EXIT_FAILURE);
}

}
