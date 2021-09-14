# Call Fortran from C++

![cmake](https://github.com/scivision/fortran-c-cpp-interface/workflows/ci_cmake/badge.svg)
![meson](https://github.com/scivision/fortran-c-cpp-interface/workflows/ci_meson/badge.svg)
[![intel-oneapi](https://github.com/scivision/fortran-c-cpp-interface/actions/workflows/intel-oneapi.yml/badge.svg)](https://github.com/scivision/fortran-c-cpp-interface/actions/workflows/intel-oneapi.yml)

Fortran subroutines and functions are easily called from C and C++.

Use the standard C binding to define variable and bind functions/subroutines.

This project is also a way to quickly check if compilers you have are ABI-compatible.
For example:

* Clang and Gfortran
* (Windows) MSVC and Intel oneAPI ifort

Demonstrate linking of

* C++ calling Fortran
* Fortran calling C++
* Fortran calling C

https://stackoverflow.com/tags/fortran-iso-c-binding/info

In general, CMake >= 3.14 has better link resolution than CMake 3.13.
In general, strongly avoid the FortranCInterface of CMake and mangling function names--just use Fortran 2003 standard `bind(C)`

## MacOS

For MacOS with Apple's Clang and Homebrew GCC,
be sure you have in ~/.zshrc like the following:
(check directory / versions on your Mac)

export LIBRARY_PATH=$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX11.1.sdk/usr/lib
export CPLUS_INCLUDE_PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX11.1.sdk/usr/include
export CXXFLAGS=-I$CPLUS_INCLUDE_PATH
export CFLAGS=$CXXFLAGS

## build

```sh
cmake -B build

cmake --build build

ctest --test-dir build
```
