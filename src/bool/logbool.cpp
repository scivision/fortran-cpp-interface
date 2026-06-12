#include <iostream>
#include <cstdlib> // for std::exit()

#include "my_bool.h"

bool logical_not(const bool_args args)
{
  std::cout << "C++ boolean sizeof(" << args.value << ") = " << sizeof(args.value) << "\n";
  if (args.dummy != 42) {
    std::cerr << "ERROR: dummy argument != 42, but " << args.dummy << "\n";
    std::exit(EXIT_FAILURE);
  }

  return !args.value;
}

bool bool_passthru(const bool_args args)
{
  std::cout << "C++ boolean sizeof(" << args.value << ") = " << sizeof(args.value) << "\n";
  if (args.dummy != 42) {
    std::cerr << "ERROR: dummy argument != 42, but " << args.dummy << "\n";
    std::exit(EXIT_FAILURE);
  }

  return args.value;
}

bool bool_true(){ return true; }
bool bool_false(){ return false; }
