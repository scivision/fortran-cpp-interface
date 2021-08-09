add_library(c_lib call_c.c)

add_executable(f_call_c ${PROJECT_SOURCE_DIR}/f_call_c.f90 $<TARGET_OBJECTS:c_lib>)
add_test(NAME FortranCallC COMMAND f_call_c)

set_tests_properties(FortranCallC
PROPERTIES
TIMEOUT 5)
