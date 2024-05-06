# Interoperability examples between C, C++ and Fortran

[![ci](https://github.com/scivision/fortran-cpp-interface/actions/workflows/ci.yml/badge.svg)](https://github.com/scivision/fortran-cpp-interface/actions/workflows/ci.yml)
[![ci_macos](https://github.com/scivision/fortran-cpp-interface/actions/workflows/ci_macos.yml/badge.svg)](https://github.com/scivision/fortran-cpp-interface/actions/workflows/ci_macos.yml)
[![oneapi-linux](https://github.com/scivision/fortran-cpp-interface/actions/workflows/oneapi-linux.yml/badge.svg)](https://github.com/scivision/fortran-cpp-interface/actions/workflows/oneapi-linux.yml)

Fortran subroutines and functions are easily called from C and C++.

Use the standard C binding to define variable and bind functions/subroutines.

This project is also a way to quickly check if compilers you have are ABI-compatible.
For example:

* Clang and Gfortran
* (Windows) MSVC and Intel oneAPI ifx

Demonstrate linking of

* C and C++ program calling Fortran libraries
* Fortran program calling C and C++ libraries

We assume the compilers are C++11 and Fortran 2018 capable.

This repo's examples are also known to work with:

* NVidia HPC SDK (nvc++, nvfortran)
* AOCC AMD Optimizing Compliers
* Cray compilers (cc, ftn)

In general, avoid the FortranCInterface of CMake and mangling function names.
Instead, use Fortran 2003 standard `bind(C)`.

Other real-world examples include
[fortran-filesystem](https://github.com/scivision/fortran-filesystem)
using C++ stdlib filesystem from Fortran and
[standard sleep implementation](./src/sleep)
as used in
[blocktran](https://github.com/fortran-gaming/blocktran)
and Fortran Standard Library.

## Build

```sh
cmake -B build

cmake --build build

ctest --test-dir build
```

Note the use of CMake target property
[LINKER_LANGUAGE](https://cmake.org/cmake/help/latest/prop_tgt/LINKER_LANGUAGE.html)
necessary for CMake with Intel oneAPI on Linux / macOS.

* C main program with Fortran library: `LINKER_LANGUAGE C`
* C++ main program with Fortran library: `LINKER_LANGUAGE CXX`
* Fortran main program with C or C++ library: `LINKER_LANGUAGE Fortran`

```cmake
add_executable(f_main main.f90 lib.cpp)
set_property(TARGET f_main PROPERTY LINKER_LANGUAGE Fortran)

add_executable(c_main main.c lib.f90)
set_property(TARGET c_main PROPERTY LINKER_LANGUAGE C)

add_executable(cpp_main main.cpp lib.f90)
set_property(TARGET cpp_main PROPERTY LINKER_LANGUAGE CXX)
```

## Examples

While the examples prioritize C++, there are also several companion C examples to go with the C++ examples.
There are also some Fortran main programs calling C or C++.

### arrays

The examples "array", "malloc", "vector" show distinct ways to send arrays to/from Fortran with C and C++.

### bool

Made workaround for [nvfortran](https://forums.developer.nvidia.com/t/nvfortran-c-bool-bind-c-not-improper-value/291896).

### Error handling

Using Fortran statement "stop" or "error stop" with a C/C++ main program works like with a Fortran main program.
The "error" examples show this.

### ISO_Fortran_binding.h

On 2019-01-12 [a GCC commit](https://github.com/gcc-mirror/gcc/commit/bbf18dc5d248a79a20ebf4b3a751669cd75485fd)
from Paul Thomas brought ISO_Fortran_binding.h to
[GCC 9](https://gcc.gnu.org/gcc-9/changes.html).

This means if using Clang compiler e.g. on macOS, you may need to switch to GCC (till Clang/Flang someday includes ISO_Fortran_binding.h).

GCC &ge; 9 and Intel oneAPI have ISO_Fortran_binding.h

## Notes

### struct memory alignment

Some examples use scalar C struct.
ISO_C_BINDING handles mapping struct to/from Fortran TYPE.
For arrays of struct, compiler
[pragma may be needed](https://stackoverflow.com/questions/53161673/data-alignment-inside-a-structure-in-intel-fortran).

Valgrind needed suppression to avoid memory alignment (uninitialized memory) warnings for C struct input to nanosleep.
### MacOS

For MacOS with Apple's Clang and Homebrew GCC,
it MAY be needed to have in ~/.zshrc like the following:
(check directory / versions on your Mac)

```sh
export LIBRARY_PATH=$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
export CPLUS_INCLUDE_PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include
export CXXFLAGS=-I$CPLUS_INCLUDE_PATH
export CFLAGS=$CXXFLAGS
```

## References

* [StackOverflow](
https://stackoverflow.com/tags/fortran-iso-c-binding/info)
