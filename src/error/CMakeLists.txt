set_directory_properties(PROPERTIES LABELS error)

add_library(error_fortran OBJECT lib.f90)

add_executable(c_fortran_error main.c)
target_link_libraries(c_fortran_error PRIVATE error_fortran)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(c_fortran_error PROPERTIES LINKER_LANGUAGE C)
add_test(NAME C_Fortran_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:c_fortran_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)


add_executable(cxx_fortran_error main.cpp)
target_link_libraries(cxx_fortran_error PRIVATE error_fortran)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(cxx_fortran_error PROPERTIES LINKER_LANGUAGE CXX)
add_test(NAME C++_Fortran_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:cxx_fortran_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

add_executable(fortran_cxx_error main.f90 lib.cpp)
set_target_properties(fortran_cxx_error PROPERTIES LINKER_LANGUAGE Fortran)
add_test(NAME Fortran_C++_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:fortran_cxx_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

add_executable(fortran_c_error main.f90 lib.c)
add_test(NAME Fortran_C_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:fortran_c_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
