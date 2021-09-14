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

# -- C calling Fortran
add_executable(c_fortran_error c/error_main.c)
target_link_libraries(c_fortran_error PRIVATE error_fortran)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(c_fortran_error PROPERTIES LINKER_LANGUAGE C)
add_test(NAME C_Fortran_error COMMAND c_fortran_error)

# -- C++ calling Fortran
add_executable(cxx_call_fortran cxx/main.cxx)
target_link_libraries(cxx_call_fortran PRIVATE math_fortran)
add_test(NAME C++_Fortran_math COMMAND cxx_call_fortran)

add_executable(cxx_fortran_error cxx/error_main.cxx)
target_link_libraries(cxx_fortran_error PRIVATE error_fortran)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(cxx_fortran_error PROPERTIES LINKER_LANGUAGE CXX)
add_test(NAME C++_Fortran_error COMMAND cxx_fortran_error)

# -- test wrapup

set_tests_properties(C++_Fortran_error C_Fortran_error PROPERTIES WILL_FAIL TRUE)

set_tests_properties(C++_Fortran_math C++_Fortran_error Fortran_call_C Fortran_call_C++ PROPERTIES
TIMEOUT 5
)
