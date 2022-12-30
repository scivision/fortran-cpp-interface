set_property(DIRECTORY PROPERTY LABELS poly_type)

add_library(poly_type_lib
${PROJECT_SOURCE_DIR}/src/poly_type/poly_type.f90
${PROJECT_SOURCE_DIR}/src/poly_type/base_mod.f90
${PROJECT_SOURCE_DIR}/src/poly_type/three.f90
${PROJECT_SOURCE_DIR}/src/poly_type/four.f90
)
target_include_directories(poly_type_lib INTERFACE ${PROJECT_SOURCE_DIR}/src/poly_type)

add_executable(c_poly_type ${PROJECT_SOURCE_DIR}/app/poly_type/main.c)
target_link_libraries(c_poly_type PRIVATE poly_type_lib)
add_test(NAME C_Fortran_poly_type COMMAND c_poly_type)

add_executable(cpp_poly_type ${PROJECT_SOURCE_DIR}/app/poly_type/main.cpp)
target_link_libraries(cpp_poly_type PRIVATE poly_type_lib)
add_test(NAME C++_Fortran_poly_type COMMAND cpp_poly_type)
