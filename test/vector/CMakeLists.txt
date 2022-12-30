set_property(DIRECTORY PROPERTY LABELS vector)

add_library(vector_fortran OBJECT mathv.f90)

add_executable(cxx_fortran_vector ${PROJECT_SOURCE_DIR}/app/vector/main.cpp $<TARGET_OBJECTS:vector_fortran>)
target_include_directories(cxx_fortran_vector PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
add_test(NAME C++_Fortran_vector COMMAND cxx_fortran_vector)

add_executable(fortran_cxx_vector vector.f90 lib.c lib.cpp)
# LINKER_LANGUAGE needed for Linux oneAPI
set_property(TARGET fortran_cxx_vector PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_vector COMMAND fortran_cxx_vector)
