#include <cstdlib>

extern "C" void err(int);

void err(int code){
  exit(code);
}
