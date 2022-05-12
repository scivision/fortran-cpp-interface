set_directory_properties(PROPERTIES LABELS array)

add_executable(cxx_fortran_array main.cpp)
target_link_libraries(cxx_fortran_array PRIVATE vector_fortran)
add_test(NAME C++_Fortran_array COMMAND cxx_fortran_array)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
