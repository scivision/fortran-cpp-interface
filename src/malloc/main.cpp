#include <iostream>

extern "C" void timestwo(int [], int [], const size_t*);


int main()
{
  const size_t N = 3;

  auto x = new int[N];
  auto x2 = new int[N];

  timestwo(&x[0], &x2[0], &N);

  for (auto i=0u; i < N; i++){
    if (x2[i] != 2*x[i]){
      std::cerr << "value " <<  x2[i] << "!=" << x[i] << std::endl;
      return EXIT_FAILURE;
    }
  }

  delete[] x;
  delete[] x2;

  std::cout << "OK: C++ malloc new" << std::endl;

  return EXIT_SUCCESS;
}
