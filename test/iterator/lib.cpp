#include <vector>

extern "C" void* initIterator_C();
extern "C" void incrementIterator_C(void*);
extern "C" int getIteratorValue_C(void*);
extern "C" void destroyIterator_C(void*);

void incrementIterator(std::vector<int>::iterator &it) {
    ++it;
}

int getIteratorValue(std::vector<int>::iterator &it) {
    return *it;
}

struct IteratorState {
    std::vector<int> vec{0, 1, 2};
    std::vector<int>::iterator it = vec.begin();
};


void* initIterator_C(){
    auto* state = new IteratorState();
    state->it = state->vec.begin();
    return state;
}

void incrementIterator_C(void* ptr){
    auto state = static_cast<IteratorState*>(ptr);
    incrementIterator(state->it);
}

int getIteratorValue_C(void* ptr){
    auto state = static_cast<IteratorState*>(ptr);
    return getIteratorValue(state->it);
}

void destroyIterator_C(void* ptr){
    auto state = static_cast<IteratorState*>(ptr);
    delete state;
}
