// https://fortran-lang.discourse.group/t/experiment-dealing-with-a-pointer-to-a-string-from-c/930/3
#include <string.h>
#include "ISO_Fortran_binding.h"

static char *str = "Hello";

void getstring_c( char **string, size_t *length ) {
  *string = str;
  *length = strlen(*string) ;
}

// Wrapper for Fortran users
int getstr( CFI_cdesc_t *s ) {
  int irc = CFI_establish(s, str, CFI_attribute_pointer, CFI_type_char,
                          strlen(str), (CFI_rank_t)0, NULL);
  return irc;
}
