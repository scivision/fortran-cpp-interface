set_property(DIRECTORY PROPERTY LABELS contiguous)

add_library(contiguous_fortran ${PROJECT_SOURCE_DIR}/src/contiguous/contiguous.f90)
target_include_directories(contiguous_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/contiguous)

add_executable(c_fortran_contiguous ${PROJECT_SOURCE_DIR}/app/contiguous/main.c)
target_link_libraries(c_fortran_contiguous PRIVATE contiguous_fortran)
add_test(NAME C_Fortran_contiguous COMMAND c_fortran_contiguous)

add_executable(cxx_fortran_contiguous ${PROJECT_SOURCE_DIR}/app/contiguous/main.cpp)
target_link_libraries(cxx_fortran_contiguous PRIVATE contiguous_fortran)
add_test(NAME C++_Fortran_contiguous COMMAND cxx_fortran_contiguous)
