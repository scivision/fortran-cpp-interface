#include <string>
#include <cstdlib>

#include "f_print.h"


int main(){
    std::string s = "Hello World";

    f_print(s.data(), s.length());

    return EXIT_SUCCESS;
}
