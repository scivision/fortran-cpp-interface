set_property(DIRECTORY PROPERTY LABELS poly_type)

add_library(poly_type_lib OBJECT lib.f90 base.f90 three.f90 four.f90)

add_executable(c_poly_type main.c)
set_property(TARGET c_poly_type PROPERTY LINKER_LANGUAGE C)
target_link_libraries(c_poly_type PRIVATE poly_type_lib)
add_test(NAME C_Fortran_poly_type COMMAND c_poly_type)

add_executable(cpp_poly_type main.cpp)
target_link_libraries(cpp_poly_type PRIVATE poly_type_lib)
add_test(NAME C++_Fortran_poly_type COMMAND cpp_poly_type)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${test_names} PROPERTY TIMEOUT 5)
