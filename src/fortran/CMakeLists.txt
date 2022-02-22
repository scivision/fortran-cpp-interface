add_library(bool_fortran bool_lib.f90)

add_library(vector_fortran OBJECT vector_lib.f90)

add_library(error_fortran OBJECT error_lib.f90)

add_library(pointer_fortran OBJECT pointer_lib.f90)

add_library(struct_fortran OBJECT struct_lib.f90)

add_library(submodule_fortran OBJECT module.f90 submodule.f90)


# -- Fortran calling C++
add_executable(fortran_cxx_vector vector_main.f90)
target_link_libraries(fortran_cxx_vector PRIVATE vector_cxx)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(fortran_cxx_vector PROPERTIES LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_vector COMMAND fortran_cxx_vector)

add_executable(fortran_cxx_struct struct_main.f90)
target_link_libraries(fortran_cxx_struct PRIVATE struct_cxx)
set_target_properties(fortran_cxx_struct PROPERTIES LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_struct COMMAND fortran_cxx_struct)

add_executable(fortran_cxx_error error_main.f90)
target_link_libraries(fortran_cxx_error PRIVATE error_cxx)
set_target_properties(fortran_cxx_error PROPERTIES LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:fortran_cxx_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

# -- Fortran calling C
add_executable(fortran_c_vector vector_main.f90)
target_link_libraries(fortran_c_vector PRIVATE vector_c)
add_test(NAME Fortran_C_vector COMMAND fortran_c_vector)

add_executable(fortran_c_struct struct_main.f90)
target_link_libraries(fortran_c_struct PRIVATE struct_c)
add_test(NAME Fortran_C_struct COMMAND fortran_c_struct)

add_executable(fortran_c_error error_main.f90)
target_link_libraries(fortran_c_error PRIVATE error_c)
add_test(NAME Fortran_C_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:fortran_c_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

set_tests_properties(
Fortran_C_vector Fortran_C_struct Fortran_C_error
Fortran_C++_vector Fortran_C++_struct Fortran_C++_error
PROPERTIES
TIMEOUT 5
)
