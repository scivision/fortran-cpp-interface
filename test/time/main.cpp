// comparing monotonic time in C++ vs Fortran
#include <chrono>
#include <iostream>
#include <cstdlib>

extern "C" long long ticker();


int main(){

  auto cpp_tic = std::chrono::steady_clock::now();
  auto cpp_toc = std::chrono::steady_clock::now();

  std::cout << "c++ toc-tic: " << (cpp_toc - cpp_tic).count() << "\n";

  auto fortran_diff = ticker();

  std::cout << "fortran toc-tic: " << fortran_diff << "\n";

  return EXIT_SUCCESS;
}
