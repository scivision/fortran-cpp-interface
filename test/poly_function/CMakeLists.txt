set_property(DIRECTORY PROPERTY LABELS poly_function)

add_library(poly_fcn
${PROJECT_SOURCE_DIR}/src/poly_function/datamod_poly.f90
${PROJECT_SOURCE_DIR}/src/poly_function/c_interface_poly.f90
)
target_include_directories(poly_fcn INTERFACE ${PROJECT_SOURCE_DIR}/src/poly_function)

add_executable(cpp_poly_fcn ${PROJECT_SOURCE_DIR}/app/poly_function/main.cpp)
target_link_libraries(cpp_poly_fcn PRIVATE poly_fcn)
add_test(NAME C++_Fortran_poly_fcn COMMAND cpp_poly_fcn)
