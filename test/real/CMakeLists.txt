set_property(DIRECTORY PROPERTY LABELS "real")

add_library(nan_f OBJECT nan.f90)
target_compile_options(nan_f PRIVATE "$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-Wno-compare-reals>")

add_executable(nan_cpp_f main.cpp)
target_link_libraries(nan_cpp_f PRIVATE nan_f)
set_property(TARGET nan_cpp_f PROPERTY LINKER_LANGUAGE CXX)
add_test(NAME NaN_Cpp_Fortran COMMAND nan_cpp_f)

add_executable(nan_c_f main.c)
target_link_libraries(nan_c_f PRIVATE nan_f)
set_property(TARGET nan_c_f PROPERTY LINKER_LANGUAGE C)
add_test(NAME NaN_C_Fortran COMMAND nan_c_f)
