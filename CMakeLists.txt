cmake_minimum_required(VERSION 3.15...3.25)
# 3.15+ for COMPILE_LANGAGE multiple languages, COMPILE_LANG_AND_ID

set(CMAKE_PROJECT_INCLUDE_BEFORE cmake/find_compilers.cmake)

project(Fortran_C_CXX_interface
LANGUAGES C CXX Fortran
)

enable_testing()

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

include(cmake/options.cmake)
include(cmake/compilers.cmake)

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
