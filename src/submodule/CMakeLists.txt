set_directory_properties(PROPERTIES LABELS submodule)

add_library(submodule_fortran OBJECT lib.f90)


add_executable(c_fortran_submodule main.c)
target_link_libraries(c_fortran_submodule PRIVATE submodule_fortran)
set_target_properties(c_fortran_submodule PROPERTIES LINKER_LANGUAGE C)
add_test(NAME C_Fortran_submodule COMMAND c_fortran_submodule)

add_executable(cxx_fortran_submodule main.cpp)
target_link_libraries(cxx_fortran_submodule PRIVATE submodule_fortran)
target_compile_definitions(cxx_fortran_submodule PRIVATE _USE_MATH_DEFINES)
add_test(NAME C++_Fortran_submodule COMMAND cxx_fortran_submodule)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
