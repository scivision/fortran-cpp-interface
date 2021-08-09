# -- C++ calling Fortran
add_library(call_f OBJECT c_call_f.f90)

add_executable(cxx_call_f cxx_call_f.cxx $<TARGET_OBJECTS:call_f>)
add_test(NAME CXXCallFortran COMMAND cxx_call_f)

# -- Fortran calling C++
add_library(cxx_lib OBJECT call_cxx.cxx)

add_executable(f_call_cxx ${PROJECT_SOURCE_DIR}/f_call_c.f90 $<TARGET_OBJECTS:cxx_lib>)
# LINKER_LANGUAGE option is necessary for ifort at least
set_target_properties(f_call_cxx PROPERTIES LINKER_LANGUAGE Fortran)
add_test(NAME FortranCallC++ COMMAND f_call_cxx)

set_tests_properties(CXXCallFortran FortranCallC++
PROPERTIES
TIMEOUT 5)
