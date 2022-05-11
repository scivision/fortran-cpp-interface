add_library(vector_c OBJECT vector_lib.c)

add_library(struct_c OBJECT struct_lib.c)

add_library(error_c OBJECT error_lib.c)


# -- C calling Fortran
add_executable(c_fortran_bool bool_main.c)
target_link_libraries(c_fortran_bool PRIVATE bool_fortran)
add_test(NAME C_Fortran_bool COMMAND c_fortran_bool)

add_executable(c_fortran_submodule submodule_main.c)
target_link_libraries(c_fortran_submodule PRIVATE submodule_fortran)
set_target_properties(c_fortran_submodule PROPERTIES LINKER_LANGUAGE C)
add_test(NAME C_Fortran_submodule COMMAND c_fortran_submodule)

add_executable(c_fortran_error error_main.c)
target_link_libraries(c_fortran_error PRIVATE error_fortran)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(c_fortran_error PROPERTIES LINKER_LANGUAGE C)
add_test(NAME C_Fortran_error
COMMAND ${CMAKE_COMMAND} -Dexe=$<TARGET_FILE:c_fortran_error> -Dexp_code=42 -P ${PROJECT_SOURCE_DIR}/cmake/test_error.cmake
)

add_executable(c_fortran_struct struct_main.c)
target_link_libraries(c_fortran_struct PRIVATE struct_fortran)
set_target_properties(c_fortran_struct PROPERTIES LINKER_LANGUAGE C)
target_compile_definitions(c_fortran_struct PRIVATE $<$<BOOL:${MSVC}>:_CRT_SECURE_NO_WARNINGS>)
add_test(NAME C_Fortran_struct COMMAND c_fortran_struct)

# --- props

get_property(targets DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY BUILDSYSTEM_TARGETS)

foreach(t IN LISTS targets)
  target_compile_features(${t} PRIVATE c_std_99)
endforeach()

get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)

set_tests_properties(${test_names} PROPERTIES TIMEOUT 5)
