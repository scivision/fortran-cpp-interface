#include <iostream>
#include <cstdlib>
#include <cstddef>
#include <vector>

#include "my_alloc.h"

int main() {
    std::vector<std::size_t> d1 = {1};

    float* A1 = nullptr;

    falloc1(&A1, d1.data());
    std::cout << "1D: allocated\n";

    A1[0] = 42.0f;
    std::cout << "1D: A1[0] = " << A1[0] << "\n";

    fdealloc1(&A1);
    std::cout << "1D: deallocated\n";

    if (A1 == nullptr) {
        std::cout << "OK: pointer is null after deallocation\n";
    }

    std::cout << "OK: fancy allocate test\n";

    return EXIT_SUCCESS;
}
