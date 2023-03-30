#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "contiguous.h"

int main(void){

size_t N = 3;

float* a = malloc(N * sizeof(float));

memcpy(a, (float[]){1, 2, 3}, N * sizeof(float));

float* p = malloc(N * sizeof(float));
p[0] = a[2];
p[1] = a[1];
p[2] = a[0];

asub(&p[0], &N);

free(a);
free(p);

printf("OK: C contiguous array\n");

return EXIT_SUCCESS;
}
