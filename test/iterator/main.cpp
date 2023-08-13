#include <cstdlib>
#include <iostream>

#include "int_iter.h"

int main(){

void* it = initIterator_C();

std::cout << getIteratorValue_C(it) << "\n";

incrementIterator_C(it);

std::cout << "OK: c++: iterator\n";
}
