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

## build

```sh
cmake -B build

cmake --build build

ctest --test-dir build
```

## Example

```fortran
module flibs

use,intrinsic:: iso_c_binding, only: c_int, c_float, c_double

implicit none

subroutine cool(X,N) bind(c)

real(c_double), intent(inout) :: X
integer(c_int), intent(in) :: N

...

end subroutine cool
```

`bind(c)` makes the name `cool` available to C/C++.
In general, strongly avoid the FortranCInterface of CMake and mangling function names--just use Fortran 2003 standard `bind(C)`
