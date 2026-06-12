# logical Boolean examples for C, C++, and Fortran

When interfacing between C or C++ and Fortran, the `logical(C_BOOL)` type is used to represent boolean values.
This test demonstrates how to use `logical(C_BOOL)` in Fortran and how it interacts with C and C++ code.

The "test/bool/bad_interface.f90" and "src/bool/bad_bool.f90" files contain examples of incorrect usage of `logical(C_BOOL)`, which should lead to runtime issues by messing up the values of following dummy arguments.

[nvfortran](https://forums.developer.nvidia.com/t/nvfortran-c-bool-bind-c-not-improper-value/291896)
supports F2018 standard `C_BOOL` if `nvfortran -Munixlogical` is used.

* [ifort might return an incorrect C_BOOL .true. in iso_c_binding - Intel Community](https://community.intel.com/t5/Intel-Fortran-Compiler/ifort-might-return-an-incorrect-C-BOOL-true-in-iso-c-binding/m-p/999050)
* [Internal representation of LOGICAL variables (The GNU Fortran Compiler](https://gcc.gnu.org/onlinedocs/gfortran/Internal-representation-of-LOGICAL-variables.html#Internal-representation-of-LOGICAL-variables)
* [Solved: Re: Error #8809: An OPTIONAL or EXTERNAL dummy argument to a BIND(C) procedure is not interoperable - Intel Community](https://community.intel.com/t5/Intel-Fortran-Compiler/Error-8809-An-OPTIONAL-or-EXTERNAL-dummy-argument-to-a-BIND-C/m-p/1250873#M154133)
* [Branchless conditional arithmetic oddities - #18 by sblionel - Language enhancement - Fortran Discourse](https://fortran-lang.discourse.group/t/branchless-conditional-arithmetic-oddities/5451/18)
* [oneAPI -standard-semantics](https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2024-1/standard-semantics.html)
* https://www.fortran90.org/src/gotchas.html#c-fortran-interoperability-of-logical
* https://info.ornl.gov/sites/publications/Files/Pub158443.pdf Section 3.1.2
* https://shroud.readthedocs.io/_/downloads/en/latest/pdf/ section 11.4

> The logical constants .TRUE. and .FALSE. are defined to be the four-byte values -1 and 0 respectively.
A logical expression is defined to be .TRUE. if its least significant bit is 1 and .FALSE. otherwise.

## Example output, Fortran interfacing with C or C++

* Intel oneAPI 2023..2026 (Linux or Windows) without `-fpscomp logicals`
* NVHPC 2023.5 without `-Munixlogical`

```
 logical_not(T): F
   storage_size()  bits   hex(in)  hex(out)
         C_BOOL:     8         1        FE
 logical_not(true) should be false: 1

 logical_not(F): T
   storage_size()  bits   hex(in)  hex(out)
         C_BOOL:     8         0        FF
```

* Intel oneAPI with `-fpscomp logicals`
* NVHPC with `-Munixlogical`

```
 logical_not(T): F
   storage_size()  bits   hex(in)  hex(out)
         C_BOOL:     8         1         0

 logical_not(F): T
  storage_size()  bits   hex(in)  hex(out)
        C_BOOL:     8         0         1
 OK: boolean-logical not
```
