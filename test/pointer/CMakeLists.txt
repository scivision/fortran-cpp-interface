set_property(DIRECTORY PROPERTY LABELS pointer)

add_library(pointer_fortran ${PROJECT_SOURCE_DIR}/src/pointer/pmod.f90)
target_include_directories(pointer_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/pointer)

add_executable(fortran_pointer_lubound pointer_bounds.f90)
add_test(NAME Fortran_pointer_lubound COMMAND fortran_pointer_lubound)

add_executable(c_fortran_pointer ${PROJECT_SOURCE_DIR}/app/pointer/main.c)
target_link_libraries(c_fortran_pointer PRIVATE pointer_fortran)
set_property(TARGET c_fortran_pointer PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_pointer COMMAND c_fortran_pointer)

add_executable(cxx_fortran_pointer ${PROJECT_SOURCE_DIR}/app/pointer/main.cpp)
target_link_libraries(cxx_fortran_pointer PRIVATE pointer_fortran)
add_test(NAME C++_Fortran_pointer COMMAND cxx_fortran_pointer)
