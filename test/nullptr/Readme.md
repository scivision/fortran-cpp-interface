# NULL / nullptr between C, C++, and Fortran

Unlike in C / C++, do not check equality with C_NULL_PTR in Fortran.
Instead, by definition the
[c_associated()](https://fortranwiki.org/fortran/show/c_associated)
logical function returns ".false." if the C_PTR is C_NULL_PTR, and ".true." otherwise.
See [strptime.f90](./strptime.f90)
for an example of checking in Fortran for a C null pointer returned from a function.
