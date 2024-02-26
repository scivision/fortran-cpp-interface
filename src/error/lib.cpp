#include <cstdlib>

extern "C" [[ noreturn ]] void err_cpp(int);

[[ noreturn ]] void err_cpp(int code){
  exit(code);
}
