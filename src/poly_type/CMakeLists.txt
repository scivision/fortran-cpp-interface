set_directory_properties(PROPERTIES LABELS poly_type)

add_executable(cpp_poly_type main.cpp lib.f90)
add_test(NAME C++_Fortran_poly_type COMMAND cpp_poly_type)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
