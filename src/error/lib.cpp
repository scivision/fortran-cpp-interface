#include <cstdlib>

extern "C" void err_div0(int code){
  exit(code);
}
