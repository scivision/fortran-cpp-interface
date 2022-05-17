# Fortran allocate with C/C++ main program

Deallocating arrays in a Fortran procedure that were allocated in another Fortran procedure, both called from a C/C++ main program is defined in a compiler vendor-dependent way.
The Intel oneAPI compiler works with the "fancy_allocate" demo, while GCC Gfortran works with all the allocate examples.
Cray Fortran ftn compiler currently doesn't work with the allocate in Fortran from C/C++ main program examples.

To be more compiler vendor independent, the general recommendation when using a C/C++ main program is to allocate the memory in C/C++ e.g. via `malloc()` or in C++ via `new`, `vector` or `array` and then pass back and forth to Fortran.
This allows memory to be managed fully, particularly with regard to freeing memory when no longer used to avoid memory leaks in long-running programs.
