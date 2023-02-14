#include <stdlib.h>
#include <stdnoreturn.h>

[[ noreturn ]] void err_c(int code){
  exit(code);
}
