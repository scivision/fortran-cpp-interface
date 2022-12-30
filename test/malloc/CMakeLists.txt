set_property(DIRECTORY PROPERTY LABELS malloc)

add_executable(c_fortran_malloc ${PROJECT_SOURCE_DIR}/app/malloc/main.c)
target_link_libraries(c_fortran_malloc PRIVATE vector_fortran)
set_property(TARGET c_fortran_malloc PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_malloc COMMAND c_fortran_malloc)

add_executable(cxx_fortran_malloc ${PROJECT_SOURCE_DIR}/app/malloc/main.cpp)
target_link_libraries(cxx_fortran_malloc PRIVATE vector_fortran)
add_test(NAME C++_Fortran_malloc COMMAND cxx_fortran_malloc)
