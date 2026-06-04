#include <cstdlib>
#include <string>
#include <iostream>

#include <memory>
#ifndef __cpp_lib_to_address
#error "C++20 std::to_address is required for this test"
#endif


char* iter_ptr(char* c){

    std::string s(c);

    auto it(s.begin());

    return std::to_address(it);
}

int main(){

    char my_str[] = "hello world";

    char* ptr = iter_ptr(my_str);

    std::cout << *ptr;
    ptr++;
    std::cout << *ptr;
    ptr++;


    return EXIT_SUCCESS;
}
