set_directory_properties(PROPERTIES LABELS bool)

add_library(bool_fortran OBJECT lib.f90)

add_executable(c_fortran_bool main.c)
target_link_libraries(c_fortran_bool PRIVATE bool_fortran)
add_test(NAME C_Fortran_bool COMMAND c_fortran_bool)

add_executable(cxx_fortran_bool main.cpp)
target_link_libraries(cxx_fortran_bool PRIVATE bool_fortran)
add_test(NAME C++_Fortran_bool COMMAND cxx_fortran_bool)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
