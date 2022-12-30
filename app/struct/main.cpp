#include <cstring>
#include <cstdlib>

#include "my_struct.h"

int main() {

struct params s;

s.my_int = 123;
s.my_bool = true;
strcpy(s.my_char, "Hello");

struct_check_f(&s);

return EXIT_SUCCESS;

}
