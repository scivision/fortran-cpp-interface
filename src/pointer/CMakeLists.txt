set_directory_properties(PROPERTIES LABELS pointer)

add_library(pointer_fortran OBJECT lib.f90)

add_executable(cxx_fortran_pointer main.cpp)
target_link_libraries(cxx_fortran_pointer PRIVATE pointer_fortran)
add_test(NAME C++_Fortran_pointer COMMAND cxx_fortran_pointer)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
