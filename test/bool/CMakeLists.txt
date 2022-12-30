set_property(DIRECTORY PROPERTY LABELS bool)

add_library(bool_fortran ${PROJECT_SOURCE_DIR}/src/bool/logbool.f90)
target_include_directories(bool_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/bool)

add_executable(c_fortran_bool ${PROJECT_SOURCE_DIR}/app/bool/main.c)
target_link_libraries(c_fortran_bool PRIVATE bool_fortran)
add_test(NAME C_Fortran_bool COMMAND c_fortran_bool)

add_executable(cxx_fortran_bool ${PROJECT_SOURCE_DIR}/app/bool/main.cpp)
target_link_libraries(cxx_fortran_bool PRIVATE bool_fortran)
add_test(NAME C++_Fortran_bool COMMAND cxx_fortran_bool)
