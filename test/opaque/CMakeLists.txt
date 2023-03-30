set_property(DIRECTORY PROPERTY LABELS opaque)

add_library(opaque_fortran ${PROJECT_SOURCE_DIR}/src/opaque/opaque.f90)
target_include_directories(opaque_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/opaque)

add_executable(c_opaque main.c)
target_link_libraries(c_opaque PRIVATE opaque_fortran)
add_test(NAME C_Fortran_opaque COMMAND c_opaque)

add_executable(cpp_opaque main.cpp)
target_link_libraries(cpp_opaque PRIVATE opaque_fortran)
add_test(NAME C++_Fortran_opaque COMMAND cpp_opaque)
