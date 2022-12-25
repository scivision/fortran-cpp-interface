set_property(DIRECTORY PROPERTY LABELS error)

add_library(error_fortran OBJECT error.f90)

add_executable(c_fortran_error main.c $<TARGET_OBJECTS:error_fortran>)
# LINKER_LANGUAGE option is necessary for ifort at least
set_property(TARGET c_fortran_error PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:c_fortran_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)


add_executable(cxx_fortran_error main.cpp $<TARGET_OBJECTS:error_fortran>)
# LINKER_LANGUAGE option is necessary for ifort at least
set_property(TARGET cxx_fortran_error PROPERTY LINKER_LANGUAGE CXX)
add_test(NAME C++_Fortran_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:cxx_fortran_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

add_executable(fortran_cxx_error main.f90 lib.cpp)
set_property(TARGET fortran_cxx_error PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:fortran_cxx_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

add_executable(fortran_c_error main.f90 lib.c)
add_test(NAME Fortran_C_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:fortran_c_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)
