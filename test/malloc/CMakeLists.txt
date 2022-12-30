set_property(DIRECTORY PROPERTY LABELS malloc)

add_executable(c_fortran_malloc main.c $<TARGET_OBJECTS:vector_fortran>)
target_include_directories(c_fortran_malloc PRIVATE ${PROJECT_SOURCE_DIR}/test/vector)
set_property(TARGET c_fortran_malloc PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_malloc COMMAND c_fortran_malloc)

add_executable(cxx_fortran_malloc main.cpp $<TARGET_OBJECTS:vector_fortran>)
target_include_directories(cxx_fortran_malloc PRIVATE ${PROJECT_SOURCE_DIR}/test/vector)
add_test(NAME C++_Fortran_malloc COMMAND cxx_fortran_malloc)
