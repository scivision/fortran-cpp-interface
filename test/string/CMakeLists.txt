set_property(DIRECTORY PROPERTY LABELS "string")

add_library(f_print OBJECT print.f90)

add_executable(string_c main.c $<TARGET_OBJECTS:f_print>)
add_executable(string_cpp main.cpp $<TARGET_OBJECTS:f_print>)

set_property(TARGET string_c PROPERTY LINKER_LANGUAGE C) # for oneAPI Linux
