cmake_minimum_required(VERSION 3.5)
project(abi_check LANGUAGES C CXX Fortran)

enable_testing()

add_library(addone OBJECT addone.c)
target_include_directories(addone PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_library(addtwo OBJECT addtwo.cpp)
target_include_directories(addtwo PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(main_f main.f90 $<TARGET_OBJECTS:addone> $<TARGET_OBJECTS:addtwo>)
set_property(TARGET main_f PROPERTY LINKER_LANGUAGE Fortran)

add_test(NAME Fortran_main COMMAND main_f)

add_library(addone_f OBJECT addone.f90)
set_property(TARGET addone_f PROPERTY Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
target_include_directories(addone_f PUBLIC ${CMAKE_CURRENT_BINARY_DIR})

add_executable(main_cpp main.cpp $<TARGET_OBJECTS:addone_f>)
target_compile_features(main_cpp PUBLIC cxx_std_17)
add_test(NAME Cpp_main COMMAND main_cpp)

add_executable(main_c main.c $<TARGET_OBJECTS:addone_f>)
set_property(TARGET main_c PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_main COMMAND main_c)
