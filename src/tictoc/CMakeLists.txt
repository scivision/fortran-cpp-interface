set_directory_properties(PROPERTIES LABELS tictoc)

add_executable(cxx_fortran_tictoc main.cpp lib.f90)
add_test(NAME C++_Fortran_tictoc COMMAND cxx_fortran_tictoc)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
