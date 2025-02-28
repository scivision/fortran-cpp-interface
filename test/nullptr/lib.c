#include <nullptr.h>
#include <stddef.h>

const char* nullchar(bool b) {
  return b ? NULL : "hello";
}
