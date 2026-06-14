#include <stdlib.h>
#include <stdio.h>

#include "contiguous.h"

int main(void){

float a[] = {1.0f, 2.0f, 3.0f};
size_t N = sizeof(a) / sizeof(a[0]);

asub(a, &N);

printf("OK: C contiguous array\n");

return EXIT_SUCCESS;
}
