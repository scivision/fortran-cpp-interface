set_property(DIRECTORY PROPERTY LABELS "string")

add_library(f_print OBJECT print.f90)

add_executable(string_c main.c $<TARGET_OBJECTS:f_print>)
add_executable(string_cpp main.cpp $<TARGET_OBJECTS:f_print>)

set_property(TARGET string_c PROPERTY LINKER_LANGUAGE C) # for oneAPI Linux

add_test(NAME string_c COMMAND string_c)
add_test(NAME string_cpp COMMAND string_cpp)

# single C_CHAR -- fails on nvfortran
# https://forums.developer.nvidia.com/t/nvfortran-iso-c-binding-with-single-char/284098

add_library(c_char OBJECT lib_char.c)
add_executable(single_char main_char.f90 $<TARGET_OBJECTS:c_char>)
set_property(TARGET single_char PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME single_char COMMAND single_char)
