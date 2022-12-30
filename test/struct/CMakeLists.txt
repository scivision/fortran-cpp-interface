set_property(DIRECTORY PROPERTY LABELS struct)

add_library(struct_fortran ${PROJECT_SOURCE_DIR}/src/struct/struct_rx.f90)
target_include_directories(struct_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/struct)

add_library(struct_cpp
${PROJECT_SOURCE_DIR}/src/struct/lib.c
${PROJECT_SOURCE_DIR}/src/struct/lib.cpp
)
target_include_directories(struct_cpp PUBLIC ${PROJECT_SOURCE_DIR}/src/struct)

add_executable(c_fortran_struct ${PROJECT_SOURCE_DIR}/app/struct/main.c)
target_link_libraries(c_fortran_struct PRIVATE struct_fortran)
target_compile_definitions(c_fortran_struct PRIVATE $<$<BOOL:${MSVC}>:_CRT_SECURE_NO_WARNINGS>)
add_test(NAME C_Fortran_struct COMMAND c_fortran_struct)

add_executable(cxx_fortran_struct ${PROJECT_SOURCE_DIR}/app/struct/main.cpp)
target_link_libraries(cxx_fortran_struct PRIVATE struct_fortran)
target_compile_definitions(cxx_fortran_struct PRIVATE $<$<BOOL:${MSVC}>:_CRT_SECURE_NO_WARNINGS>)
add_test(NAME C++_Fortran_struct COMMAND cxx_fortran_struct)

add_executable(fortran_cxx_struct struct_tx.f90)
target_link_libraries(fortran_cxx_struct PRIVATE struct_cpp)
set_property(TARGET fortran_cxx_struct PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_struct COMMAND fortran_cxx_struct)
