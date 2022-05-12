set_directory_properties(PROPERTIES LABELS opaque)

add_library(opaque_fortran OBJECT lib.f90)

add_executable(c_opaque main.c)
target_link_libraries(c_opaque PRIVATE opaque_fortran)
add_test(NAME C_Fortran_opaque COMMAND c_opaque)

add_executable(cpp_opaque main.cpp)
target_link_libraries(cpp_opaque PRIVATE opaque_fortran)
add_test(NAME C++_Fortran_opaque COMMAND cpp_opaque)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
