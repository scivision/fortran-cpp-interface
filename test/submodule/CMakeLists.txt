set_property(DIRECTORY PROPERTY LABELS submodule)

add_library(submodule_fortran ${PROJECT_SOURCE_DIR}/src/submodule/bindmod.f90)
target_include_directories(submodule_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/submodule)

add_executable(c_fortran_submodule main.c)
target_link_libraries(c_fortran_submodule PRIVATE submodule_fortran)
add_test(NAME C_Fortran_submodule COMMAND c_fortran_submodule)

add_executable(cxx_fortran_submodule main.cpp)
target_link_libraries(cxx_fortran_submodule PRIVATE submodule_fortran)
target_compile_definitions(cxx_fortran_submodule PRIVATE _USE_MATH_DEFINES)
add_test(NAME C++_Fortran_submodule COMMAND cxx_fortran_submodule)
