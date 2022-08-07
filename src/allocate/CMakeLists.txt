set_property(DIRECTORY PROPERTY LABELS allocate)

add_library(fancy OBJECT fancy.f90)

add_executable(fancy_interactive interactive.cpp $<TARGET_OBJECTS:fancy>)

add_executable(fancy_allocate intel.cpp $<TARGET_OBJECTS:fancy>)
add_test(NAME FancyAllocate COMMAND fancy_allocate)

add_executable(cxx_fortran_allocate main.cpp lib.f90)
add_test(NAME C++_Fortran_allocate COMMAND cxx_fortran_allocate)
if(CMAKE_Fortran_COMPILER_ID STREQUAL "Cray" OR CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
set_property(TEST C++_Fortran_allocate PROPERTY SKIP_RETURN_CODE 77)
endif()

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${test_names} PROPERTY TIMEOUT 5)
