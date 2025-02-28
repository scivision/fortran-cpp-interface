# Pointer Fortran C C++

[NULL (legacy)](https://en.cppreference.com/w/c/types/NULL)
and modern "nullptr" in
[C++11](https://en.cppreference.com/w/cpp/language/nullptr)
[C23](https://en.cppreference.com/w/c/language/nullptr)
are represented in Fortran
[iso_c_binding](https://fortranwiki.org/fortran/show/iso_c_binding).

Unlike in C / C++, do not check equality with C_NULL_PTR in Fortran.
Instead, by definition the
[c_associated()](https://fortranwiki.org/fortran/show/c_associated)
logical function returns ".false." if the C_PTR is C_NULL_PTR, and ".true." otherwise.
See [strptime.f90](./strptime.f90)
for an example of checking in Fortran for a C null pointer returned from a function.
