# Interoperability examples between C, C++ and Fortran

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

* C and C++ program calling Fortran libraries
* Fortran program calling C and C++ libraries

We assume the compilers are C++11 and Fortran 2018 capable.
We CI test with compilers including:

* GCC &ge; 7
* Clang &ge; 6
* Intel oneAPI

In general, strongly avoid the FortranCInterface of CMake and mangling function names--just use Fortran 2003 standard `bind(C)`.

## Examples

C++ examples include [./cxx/vector_main.cxx](vector_main.cxx) that shows using a C++ contiguous
[std::vector](https://en.cppreference.com/w/cpp/container/vector)
to pass 1-D arrays to/from Fortran.

## build

```sh
cmake -B build

cmake --build build

ctest --test-dir build
```

OR from Meson

```sh
meson build
meson compile -C build
meson test -C build
```

### MacOS

For MacOS with Apple's Clang and Homebrew GCC,
be sure you have in ~/.zshrc like the following:
(check directory / versions on your Mac)

```sh
export LIBRARY_PATH=$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
export CPLUS_INCLUDE_PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include
export CXXFLAGS=-I$CPLUS_INCLUDE_PATH
export CFLAGS=$CXXFLAGS
```

## Error handling in Fortran with C/C++ main program

Using Fortran statement "stop" or "error stop" with a C/C++ main program works like with a Fortran main program.
The "error*" examples show this.

## References

* [StackOverflow](
https://stackoverflow.com/tags/fortran-iso-c-binding/info)
