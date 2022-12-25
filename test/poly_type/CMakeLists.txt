set_property(DIRECTORY PROPERTY LABELS poly_type)

add_library(poly_type_lib OBJECT poly_type.f90 base_mod.f90 three.f90 four.f90)

add_executable(c_poly_type main.c $<TARGET_OBJECTS:poly_type_lib>)
set_property(TARGET c_poly_type PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_poly_type COMMAND c_poly_type)

add_executable(cpp_poly_type main.cpp $<TARGET_OBJECTS:poly_type_lib>)
add_test(NAME C++_Fortran_poly_type COMMAND cpp_poly_type)
