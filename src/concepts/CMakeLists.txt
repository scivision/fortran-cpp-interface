add_library(string_array_fortran OBJECT string_array_lib.f90)

add_executable(c_fortran_string_array c/string_array_main.c $<TARGET_OBJECTS:string_array_fortran>)
set_property(TARGET c_fortran_string_array PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_string_array COMMAND c_fortran_string_array)
