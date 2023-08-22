add_library(raise_exception OBJECT raise_exception.cpp)

add_executable(exception_cpp exception.cpp $<TARGET_OBJECTS:raise_exception>)

add_test(NAME exception_cpp_invalid_arg COMMAND exception_cpp notnumber)
set_property(TEST exception_cpp_invalid_arg PROPERTY PASS_REGULAR_EXPRESSION "std::invalid_argument")
