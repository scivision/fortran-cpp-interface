// comparing monotonic time in C++ vs Fortran
#include <chrono>
#include <iostream>

extern "C" long long ticker();


int main(){

  auto cpp_tic = std::chrono::steady_clock::now();
  auto cpp_toc = std::chrono::steady_clock::now();

  std::cout << "c++ toc-tic: " << (cpp_toc - cpp_tic).count() << std::endl;

  auto fortran_diff = ticker();

  std::cout << "fortran toc-tic: " << fortran_diff << std::endl;

  return EXIT_SUCCESS;
}
