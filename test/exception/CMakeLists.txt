add_library(raise_exception OBJECT raise_exception.cpp)

add_executable(exception_cpp exception.cpp $<TARGET_OBJECTS:raise_exception>)
add_test(NAME exception_cpp_invalid_arg COMMAND exception_cpp notnumber)

add_executable(exception_fortran exception.f90 $<TARGET_OBJECTS:raise_exception>)
set_property(TARGET exception_fortran PROPERTY LINKER_LANGUAGE ${linker_lang})
add_test(NAME exception_fortran_invalid_arg COMMAND ${CMAKE_COMMAND} -E env $<TARGET_FILE:exception_fortran>)

set_property(TEST exception_cpp_invalid_arg exception_fortran_invalid_arg
PROPERTY PASS_REGULAR_EXPRESSION "caught by std::invalid_argument"
)

# have not found a way to reliably detect the test will fail as on CI try_run() passes this same test that sigabrts here.
# SKIP is like XFAIL here, showing we can detect and skip in CI
set_property(TEST exception_fortran_invalid_arg PROPERTY SKIP_REGULAR_EXPRESSION "SIGABRT;[aA]bort")
