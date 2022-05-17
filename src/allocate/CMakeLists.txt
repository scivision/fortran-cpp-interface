set_directory_properties(PROPERTIES LABELS allocate)

add_library(fancy OBJECT fancy.f90)

add_executable(fancy_interactive interactive.cpp)
target_link_libraries(fancy_interactive PRIVATE fancy)

add_executable(fancy_allocate intel.cpp)
target_link_libraries(fancy_allocate PRIVATE fancy)
add_test(NAME FancyAllocate COMMAND fancy_allocate)

add_executable(cxx_fortran_allocate main.cpp lib.f90)
add_test(NAME C++_Fortran_allocate COMMAND cxx_fortran_allocate)
set_tests_properties(C++_Fortran_allocate PROPERTIES
SKIP_RETURN_CODE 77
)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
