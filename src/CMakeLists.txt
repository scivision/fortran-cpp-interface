add_subdirectory(c)

add_subdirectory(cxx)

add_subdirectory(fortran)

# -- Fortran calling C++
add_executable(fortran_call_cxx fortran/main.f90)
target_link_libraries(fortran_call_cxx PRIVATE math_cxx)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(fortran_call_cxx PROPERTIES LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_call_C++ COMMAND fortran_call_cxx)

# -- Fortran calling C
add_executable(fortran_call_c fortran/main.f90)
target_link_libraries(fortran_call_c PRIVATE math_c)
add_test(NAME Fortran_call_C COMMAND fortran_call_c)

# -- C++ calling Fortran
add_executable(cxx_call_fortran cxx/main.cxx)
target_link_libraries(cxx_call_fortran PRIVATE math_fortran)
add_test(NAME C++_call_Fortran COMMAND cxx_call_fortran)

set_tests_properties(C++_call_Fortran Fortran_call_C Fortran_call_C++ PROPERTIES
TIMEOUT 5
)
