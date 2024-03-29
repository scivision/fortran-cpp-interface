// returns a pointer to fortran
#include <stddef.h>
#include <stdio.h>
#include <string.h>

char* get_null(char*);

char* get_null(char* c){
  if (strlen(c) == 0){
    printf("C got empty string from Fortran\n");
    return NULL;
  }
  else{
    printf("C got non-empty string from Fortran\n");
    return c;
  }
}
