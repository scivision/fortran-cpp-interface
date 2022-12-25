set_property(DIRECTORY PROPERTY LABELS pointer)

add_library(pointer_fortran OBJECT pmod.f90)

add_executable(c_fortran_pointer main.c $<TARGET_OBJECTS:pointer_fortran>)
target_include_directories(c_fortran_pointer PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
set_property(TARGET c_fortran_pointer PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_pointer COMMAND c_fortran_pointer)

add_executable(cxx_fortran_pointer main.cpp $<TARGET_OBJECTS:pointer_fortran>)
target_include_directories(cxx_fortran_pointer PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
add_test(NAME C++_Fortran_pointer COMMAND cxx_fortran_pointer)
