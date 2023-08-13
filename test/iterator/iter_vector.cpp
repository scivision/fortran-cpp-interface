#include <cstdlib>
#include <vector>
#include <iostream>

void incrementIterator(std::vector<int>::iterator &it) {
    ++it;
}

int main(){

std::vector<int> vec{0, 1, 2};
auto it = vec.begin();

void* ptr = &(*it);

auto it2 = static_cast<std::vector<int>::iterator*>(ptr);


std::cout << *it << std::endl;
incrementIterator(it);
std::cout << *it << std::endl;
incrementIterator(it);
std::cout << *it << std::endl;
incrementIterator(it);

return EXIT_SUCCESS;
}
