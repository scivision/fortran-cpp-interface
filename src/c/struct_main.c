#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#include "my_struct.h"

int main(void) {

struct params s;

s.my_int = 123;
s.my_bool = true;
strcpy(s.my_char, "Hello");

struct_check(s);

return EXIT_SUCCESS;

}
