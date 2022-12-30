#include <cstdlib>

extern "C" void err_cpp(int);

void err_cpp(int code){
  exit(code);
}
