set_property(DIRECTORY PROPERTY LABELS vector)

add_library(vector_fortran ${PROJECT_SOURCE_DIR}/src/vector/mathv.f90)
target_include_directories(vector_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/vector)

add_executable(cxx_fortran_vector ${PROJECT_SOURCE_DIR}/app/vector/main.cpp)
target_link_libraries(cxx_fortran_vector PRIVATE vector_fortran)

add_test(NAME C++_Fortran_vector COMMAND cxx_fortran_vector)

add_executable(fortran_cxx_vector vector.f90
${PROJECT_SOURCE_DIR}/src/vector/lib.c
${PROJECT_SOURCE_DIR}/src/vector/lib.cpp
)
# LINKER_LANGUAGE needed for Linux oneAPI
set_property(TARGET fortran_cxx_vector PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_vector COMMAND fortran_cxx_vector)
