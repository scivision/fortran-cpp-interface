set_property(DIRECTORY PROPERTY LABELS struct)

add_library(struct_c OBJECT lib.c)
add_library(struct_cxx OBJECT lib.cpp)
add_library(struct_fortran OBJECT lib.f90)


add_executable(c_fortran_struct main.c $<TARGET_OBJECTS:struct_fortran>)
set_property(TARGET c_fortran_struct PROPERTY LINKER_LANGUAGE C)
target_compile_definitions(c_fortran_struct PRIVATE $<$<BOOL:${MSVC}>:_CRT_SECURE_NO_WARNINGS>)
add_test(NAME C_Fortran_struct COMMAND c_fortran_struct)

add_executable(cxx_fortran_struct main.cpp $<TARGET_OBJECTS:struct_fortran>)
target_include_directories(cxx_fortran_struct PRIVATE ${PROJECT_SOURCE_DIR}/src/c)
set_property(TARGET cxx_fortran_struct PROPERTY LINKER_LANGUAGE CXX)
target_compile_definitions(cxx_fortran_struct PRIVATE $<$<BOOL:${MSVC}>:_CRT_SECURE_NO_WARNINGS>)
add_test(NAME C++_Fortran_struct COMMAND cxx_fortran_struct)

add_executable(fortran_cxx_struct main.f90 $<TARGET_OBJECTS:struct_cxx>)
set_property(TARGET fortran_cxx_struct PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_struct COMMAND fortran_cxx_struct)

add_executable(fortran_c_struct main.f90 $<TARGET_OBJECTS:struct_c>)
add_test(NAME Fortran_C_struct COMMAND fortran_c_struct)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${test_names} PROPERTY TIMEOUT 5)
