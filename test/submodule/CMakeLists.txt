set_property(DIRECTORY PROPERTY LABELS submodule)

add_library(submodule_fortran OBJECT bindmod.f90)

add_executable(c_fortran_submodule main.c $<TARGET_OBJECTS:submodule_fortran>)
set_property(TARGET c_fortran_submodule PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_submodule COMMAND c_fortran_submodule)

add_executable(cxx_fortran_submodule main.cpp $<TARGET_OBJECTS:submodule_fortran>)
target_compile_definitions(cxx_fortran_submodule PRIVATE _USE_MATH_DEFINES)
add_test(NAME C++_Fortran_submodule COMMAND cxx_fortran_submodule)
