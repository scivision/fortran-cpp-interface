set_property(DIRECTORY PROPERTY LABELS bool)

add_library(bool_fortran ${PROJECT_SOURCE_DIR}/src/bool/logbool.f90)
target_include_directories(bool_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/bool)

add_library(bool_cxx ${PROJECT_SOURCE_DIR}/src/bool/logbool.cpp)
target_include_directories(bool_cxx PUBLIC ${PROJECT_SOURCE_DIR}/src/bool)

add_library(bool_c ${PROJECT_SOURCE_DIR}/src/bool/logbool.c)
target_include_directories(bool_c PUBLIC ${PROJECT_SOURCE_DIR}/src/bool)

add_executable(c_fortran_bool main.c)
target_link_libraries(c_fortran_bool PRIVATE bool_fortran)
add_test(NAME C_Fortran_bool COMMAND c_fortran_bool)

add_executable(cxx_fortran_bool main.cpp)
target_link_libraries(cxx_fortran_bool PRIVATE bool_fortran)
add_test(NAME Cpp_Fortran_bool COMMAND cxx_fortran_bool)

add_executable(fortran_cxx_bool main.f90)
target_link_libraries(fortran_cxx_bool PRIVATE bool_cxx)
set_property(TARGET fortran_cxx_bool PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_Cpp_bool COMMAND fortran_cxx_bool)

add_executable(fortran_c_bool main.f90)
target_link_libraries(fortran_c_bool PRIVATE bool_c)
set_property(TARGET fortran_c_bool PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C_bool COMMAND fortran_c_bool)

add_executable(c_cxx_bool main.c)
target_link_libraries(c_cxx_bool PRIVATE bool_cxx)
add_test(NAME C_Cpp_bool COMMAND c_cxx_bool)

add_executable(cxx_c_bool main.cpp)
target_link_libraries(cxx_c_bool PRIVATE bool_c)
add_test(NAME Cpp_bool COMMAND cxx_c_bool)
