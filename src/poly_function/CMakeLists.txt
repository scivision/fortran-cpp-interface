set_property(DIRECTORY PROPERTY LABELS poly_function)

add_executable(cpp_poly_fcn main.cpp data_lib.f90 fcn_lib.f90)
add_test(NAME C++_Fortran_poly_fcn COMMAND cpp_poly_fcn)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${test_names} PROPERTY TIMEOUT 5)
