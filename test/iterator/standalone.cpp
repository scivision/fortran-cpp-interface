#include <cstdlib>
#include <string>
#include <iostream>


char* iter_ptr(char* c){

    std::string s(c);

    std::string::iterator it(s.begin());

    return &(*it);
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
