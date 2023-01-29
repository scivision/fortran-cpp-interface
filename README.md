# Interoperability examples between C, C++ and Fortran

[![ci](https://github.com/scivision/fortran-cpp-interface/actions/workflows/ci.yml/badge.svg)](https://github.com/scivision/fortran-cpp-interface/actions/workflows/ci.yml)
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
We CI test with compilers including:

* GCC &ge; 7
* Clang &ge; 6
* Intel oneAPI

This repo's examples are also known to work with:

* NVidia HPC SDK (nvc++, nvfortran)
* AOCC AMD Optimizing Compliers
* Cray compilers (cc, ftn)

In general, avoid the FortranCInterface of CMake and mangling function names.
Instead, use Fortran 2003 standard `bind(C)`.

Other real-world examples include
[fortran-filesystem](https://github.com/scivision/fortran-filesystem)
using C++ stdlib filesystem from Fortran and
[fortran-sleep](https://github.com/scivision/fortran-sleep)
standard sleep implementation as used in
[blocktran](https://github.com/fortran-gaming/blocktran)
and Fortran Standard Library.

## Build

```sh
cmake -B build

cmake --build build

ctest --test-dir build
```

## Examples

While the examples prioritize C++, there are also several companion C examples to go with the C++ examples.
There are also some Fortran main programs calling C or C++.

### arrays

The examples "array", "malloc", "vector" show distinct ways to send arrays to/from Fortran with C and C++.

### Error handling

Using Fortran statement "stop" or "error stop" with a C/C++ main program works like with a Fortran main program.
The "error" examples show this.

### ISO_Fortran_binding.h

On 2019-01-12 [a GCC commit](https://github.com/gcc-mirror/gcc/commit/bbf18dc5d248a79a20ebf4b3a751669cd75485fd)
from Paul Thomas brought ISO_Fortran_binding.h to
[GCC 9](https://gcc.gnu.org/gcc-9/changes.html).

This means if using Clang compiler e.g. on macOS, you may need to switch to GCC (till Clang/Flang someday includes ISO_Fortran_binding.h).


## Notes

### MacOS

For MacOS with Apple's Clang and Homebrew GCC,
it MAY be needed to have in ~/.zprofile like the following:
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
