#include <iostream>
#include <vector>

extern "C" void timestwo(int [], int [], size_t*);


int main()
{

  std::vector<int> x = {0, 1, 2};
  auto N = x.size();
  std::vector<int> x2(N);

  timestwo(&x.front(), &x2.front(), &N);

  for (auto i=0u; i < x2.size(); i++){
    if (x2[i] != 2*x[i]){
      fprintf(stderr, "value %d != %d", x2[i], x[i]);
      return EXIT_FAILURE;
    }
  }

  return EXIT_SUCCESS;
}
