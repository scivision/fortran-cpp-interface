cmake_minimum_required(VERSION 3.19)

project(Fortran_C_CXX_interface
LANGUAGES C CXX Fortran
)

enable_testing()

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED true)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED true)

include (cmake/compilers.cmake)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

add_subdirectory(src/allocate)
add_subdirectory(src/array)
add_subdirectory(src/bool)
add_subdirectory(src/error)
add_subdirectory(src/malloc)
add_subdirectory(src/opaque)
add_subdirectory(src/pointer)
add_subdirectory(src/poly_function)
add_subdirectory(src/poly_type)
add_subdirectory(src/struct)
add_subdirectory(src/submodule)
add_subdirectory(src/tictoc)
add_subdirectory(src/vector)
