set_property(DIRECTORY PROPERTY LABELS tictoc)

add_executable(cxx_fortran_tictoc main.cpp clock.f90)
add_test(NAME C++_Fortran_tictoc COMMAND cxx_fortran_tictoc)
