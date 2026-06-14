set_property(DIRECTORY PROPERTY LABELS contiguous)

if(DEFINED f08contiguous AND NOT f08contiguous)
  return()
endif()

add_library(contiguous_fortran ${PROJECT_SOURCE_DIR}/src/contiguous/contiguous.f90)
target_include_directories(contiguous_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/contiguous)

add_executable(c_fortran_contiguous main.c)
target_link_libraries(c_fortran_contiguous PRIVATE contiguous_fortran)
add_test(NAME C_Fortran_contiguous COMMAND c_fortran_contiguous)

add_executable(cxx_fortran_contiguous main.cpp)
target_link_libraries(cxx_fortran_contiguous PRIVATE contiguous_fortran)
add_test(NAME Cpp_Fortran_contiguous COMMAND cxx_fortran_contiguous)

add_executable(fortran_contiguous_bad bad.f90)
target_link_libraries(fortran_contiguous_bad PRIVATE contiguous_fortran)
add_test(NAME Fortran_contiguous_bad COMMAND fortran_contiguous_bad)
set_tests_properties(Fortran_contiguous_bad PROPERTIES WILL_FAIL true)
