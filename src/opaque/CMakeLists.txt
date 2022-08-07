set_property(DIRECTORY PROPERTY LABELS opaque)

add_library(opaque_fortran OBJECT lib.f90)

add_executable(c_opaque main.c $<TARGET_OBJECTS:opaque_fortran>)
set_property(TARGET c_opaque PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_opaque COMMAND c_opaque)

add_executable(cpp_opaque main.cpp $<TARGET_OBJECTS:opaque_fortran>)
add_test(NAME C++_Fortran_opaque COMMAND cpp_opaque)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${test_names} PROPERTY TIMEOUT 5)
