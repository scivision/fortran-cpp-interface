#include <stdlib.h>
#include <string.h>

#include "f_print.h"


int main(){
    char s[] = "Hello World\0";

    f_print(s, strlen(s));

    return EXIT_SUCCESS;
}
