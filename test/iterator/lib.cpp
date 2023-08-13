#include <vector>

extern "C" void* initIterator_C();
extern "C" void incrementIterator_C(void*);
extern "C" int getIteratorValue_C(void*);

auto initIterator(){
    std::vector<int> vec{0, 1, 2};
    return vec;
}

void incrementIterator(std::vector<int>::iterator &it) {
    ++it;
}

int getIteratorValue(std::vector<int>::iterator &it) {
    return *it;
}


void* initIterator_C(){
    auto it = initIterator();
    void* ptr = &(*it.begin());
    return ptr;
}

void incrementIterator_C(void* ptr){
    auto it = static_cast<std::vector<int>::iterator*>(ptr);
    incrementIterator(*it);
}

int getIteratorValue_C(void* ptr){
    auto it = static_cast<std::vector<int>::iterator*>(ptr);
    return getIteratorValue(*it);
}
