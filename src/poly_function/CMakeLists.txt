set_property(DIRECTORY PROPERTY LABELS poly_function)

add_executable(cpp_poly_fcn main.cpp data_lib.f90 fcn_lib.f90)
target_include_directories(cpp_poly_fcn PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
add_test(NAME C++_Fortran_poly_fcn COMMAND cpp_poly_fcn)
