add_library(vector_cxx OBJECT vector_lib.cxx)

add_library(struct_cxx OBJECT struct_lib.cxx)
target_include_directories(struct_cxx PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../c)

add_library(error_cxx OBJECT error_lib.cxx)

# -- C++ calling Fortran
add_executable(cxx_fortran_bool bool_main.cxx)
target_link_libraries(cxx_fortran_bool PRIVATE bool_fortran)
add_test(NAME C++_Fortran_bool COMMAND cxx_fortran_bool)

add_executable(cxx_fortran_submodule submodule_main.cxx)
target_link_libraries(cxx_fortran_submodule PRIVATE submodule_fortran)
target_compile_definitions(cxx_fortran_submodule PRIVATE _USE_MATH_DEFINES)
add_test(NAME C++_Fortran_submodule COMMAND cxx_fortran_submodule)

add_executable(cxx_fortran_array array_main.cxx)
target_link_libraries(cxx_fortran_array PRIVATE vector_fortran)
add_test(NAME C++_Fortran_array COMMAND cxx_fortran_array)

add_executable(cxx_fortran_vector vector_main.cxx)
target_link_libraries(cxx_fortran_vector PRIVATE vector_fortran)
add_test(NAME C++_Fortran_vector COMMAND cxx_fortran_vector)

add_executable(cxx_fortran_pointer pointer_main.cxx)
target_link_libraries(cxx_fortran_pointer PRIVATE pointer_fortran)
add_test(NAME C++_Fortran_pointer COMMAND cxx_fortran_pointer)

add_executable(cxx_fortran_error error_main.cxx)
target_link_libraries(cxx_fortran_error PRIVATE error_fortran)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(cxx_fortran_error PROPERTIES LINKER_LANGUAGE CXX)
add_test(NAME C++_Fortran_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:cxx_fortran_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

add_executable(cxx_fortran_struct struct_main.cxx)
target_include_directories(cxx_fortran_struct PRIVATE ${PROJECT_SOURCE_DIR}/src/c)
target_link_libraries(cxx_fortran_struct PRIVATE struct_fortran)
set_target_properties(cxx_fortran_struct PROPERTIES LINKER_LANGUAGE CXX)
target_compile_definitions(cxx_fortran_struct PRIVATE $<$<BOOL:${MSVC}>:_CRT_SECURE_NO_WARNINGS>)
add_test(NAME C++_Fortran_struct COMMAND cxx_fortran_struct)


set_tests_properties(
C++_Fortran_array C++_Fortran_vector C++_Fortran_error C++_Fortran_struct C++_Fortran_submodule
PROPERTIES
TIMEOUT 5
)
