set_property(DIRECTORY PROPERTY LABELS array)

add_executable(cxx_f_array main.cpp)
target_link_libraries(cxx_f_array PRIVATE vector_fortran)
add_test(NAME CPP_array COMMAND cxx_f_array)

add_executable(fortran_c_array main.f90 lib.c)
add_test(NAME Fortran_C_array COMMAND fortran_c_array)

add_executable(fortran_cpp_array main.f90 lib.cpp)
set_property(TARGET fortran_cpp_array PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_CPP_array COMMAND fortran_cpp_array)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${test_names} PROPERTY TIMEOUT 5)
