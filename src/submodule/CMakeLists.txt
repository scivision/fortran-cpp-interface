set_property(DIRECTORY PROPERTY LABELS submodule)

add_library(submodule_fortran OBJECT lib.f90)


add_executable(c_fortran_submodule main.c $<TARGET_OBJECTS:submodule_fortran>)
set_property(TARGET c_fortran_submodule PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_submodule COMMAND c_fortran_submodule)

add_executable(cxx_fortran_submodule main.cpp $<TARGET_OBJECTS:submodule_fortran>)
target_compile_definitions(cxx_fortran_submodule PRIVATE _USE_MATH_DEFINES)
add_test(NAME C++_Fortran_submodule COMMAND cxx_fortran_submodule)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${test_names} PROPERTY TIMEOUT 5)
