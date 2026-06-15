#include <stddef.h>

#if __STDC_VERSION__ < 202311L
#include <stdbool.h>
#endif

const char* nullchar(bool b) {
  return b ? nullptr : "hello";
}
