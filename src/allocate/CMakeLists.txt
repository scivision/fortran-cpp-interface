set_directory_properties(PROPERTIES LABELS allocate)

add_executable(oneapi_bug_allocate intel.cpp intel.f90)

add_executable(cxx_fortran_allocate main.cpp lib.f90)
add_test(NAME C++_Fortran_allocate COMMAND cxx_fortran_allocate)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
