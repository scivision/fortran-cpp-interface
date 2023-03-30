set_property(DIRECTORY PROPERTY LABELS error)

add_library(error_fortran ${PROJECT_SOURCE_DIR}/src/error/error.f90)
target_include_directories(error_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/error)

add_executable(c_fortran_error main.c)
target_link_libraries(c_fortran_error PRIVATE error_fortran)
add_test(NAME C_Fortran_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:c_fortran_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)


add_executable(cxx_fortran_error main.cpp)
target_link_libraries(cxx_fortran_error PRIVATE error_fortran)
add_test(NAME C++_Fortran_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:cxx_fortran_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

add_executable(fortran_cxx_error error_cpp.f90 ${PROJECT_SOURCE_DIR}/src/error/lib.cpp)
set_property(TARGET fortran_cxx_error PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:fortran_cxx_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

add_executable(fortran_c_error error_c.f90 ${PROJECT_SOURCE_DIR}/src/error/lib.c)
add_test(NAME Fortran_C_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:fortran_c_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)
