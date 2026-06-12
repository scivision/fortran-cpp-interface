set_property(DIRECTORY PROPERTY LABELS bool)

add_library(bool_fortran OBJECT ${PROJECT_SOURCE_DIR}/src/bool/logbool.f90)
target_include_directories(bool_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/bool)

add_library(bool_cxx OBJECT ${PROJECT_SOURCE_DIR}/src/bool/logbool.cpp)
target_include_directories(bool_cxx PUBLIC ${PROJECT_SOURCE_DIR}/src/bool)

add_library(bool_c OBJECT ${PROJECT_SOURCE_DIR}/src/bool/logbool.c)
target_include_directories(bool_c PUBLIC ${PROJECT_SOURCE_DIR}/src/bool)

add_executable(c_fortran_bool main.c)
target_link_libraries(c_fortran_bool PRIVATE bool_fortran)
add_test(NAME C_Fortran_bool COMMAND c_fortran_bool)

add_executable(cxx_fortran_bool main.cpp)
target_link_libraries(cxx_fortran_bool PRIVATE bool_fortran)
add_test(NAME Cpp_Fortran_bool COMMAND cxx_fortran_bool)

add_executable(fortran_cxx_bool main.f90)
target_link_libraries(fortran_cxx_bool PRIVATE bool_cxx)
set_property(TARGET fortran_cxx_bool PROPERTY LINKER_LANGUAGE ${linker_lang})
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
add_test(NAME Cpp_C_bool COMMAND cxx_c_bool)


add_executable(fortran_c_bad_bool bad_interface.f90)
target_link_libraries(fortran_c_bad_bool PRIVATE bool_c)
set_property(TARGET fortran_c_bad_bool PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C_bad_bool COMMAND fortran_c_bad_bool)

add_library(bad_bool_fortran OBJECT ${PROJECT_SOURCE_DIR}/src/bool/bad_bool.f90)
target_include_directories(bad_bool_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/bool)

add_executable(c_fortran_bad_bool main.c)
target_link_libraries(c_fortran_bad_bool PRIVATE bad_bool_fortran)
add_test(NAME C_Fortran_bad_bool COMMAND c_fortran_bad_bool)

add_executable(cxx_fortran_bad_bool main.cpp)
target_link_libraries(cxx_fortran_bad_bool PRIVATE bad_bool_fortran)
add_test(NAME Cpp_Fortran_bad_bool COMMAND cxx_fortran_bad_bool)

set_tests_properties(C_Fortran_bad_bool Fortran_C_bad_bool Cpp_Fortran_bad_bool PROPERTIES WILL_FAIL true)
