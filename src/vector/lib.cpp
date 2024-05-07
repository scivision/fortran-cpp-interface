// NOTE: extern "C" is necessary to get the function name in the library to be "timestwo"
// as seen by
// nm libcxx.a
// or whatever you name this library file.
#include <cstddef>

#include "my_vector.h"

void timestwo_cpp(const int x[], int x2[], const size_t N){
  for (size_t i=0; i<N; i++)
    x2[i] = x[i] * 2;
}
