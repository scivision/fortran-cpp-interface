set_property(DIRECTORY PROPERTY LABELS array)

add_executable(cxx_f_array main.cpp)
target_link_libraries(cxx_f_array PRIVATE vector_fortran)
add_test(NAME CPP_array COMMAND cxx_f_array)


# object library to work with Visual Studio generator
add_library(fortran_array OBJECT array.f90)

add_executable(fortran_cpp_array lib.c lib.cpp $<TARGET_OBJECTS:fortran_array>)
set_property(TARGET fortran_cpp_array PROPERTY LINKER_LANGUAGE ${linker_lang})


add_test(NAME Fortran_CPP_array COMMAND fortran_cpp_array)
