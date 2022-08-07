set_property(DIRECTORY PROPERTY LABELS vector)

add_library(vector_c OBJECT lib.c)
add_library(vector_fortran OBJECT lib.f90)
add_library(vector_cxx OBJECT lib.cpp)

add_executable(cxx_fortran_vector main.cpp $<TARGET_OBJECTS:vector_fortran>)
add_test(NAME C++_Fortran_vector COMMAND cxx_fortran_vector)

add_executable(fortran_cxx_vector main.f90 $<TARGET_OBJECTS:vector_cxx>)
# LINKER_LANGUAGE option is necessary for ifort at least
set_property(TARGET fortran_cxx_vector PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_vector COMMAND fortran_cxx_vector)

add_executable(fortran_c_vector main.f90 $<TARGET_OBJECTS:vector_c>)
add_test(NAME Fortran_C_vector COMMAND fortran_c_vector)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${test_names} PROPERTY TIMEOUT 5)
