cmake_minimum_required(VERSION 3.14...3.21)

project(Fortran_C_CXX_interface
LANGUAGES C CXX Fortran
VERSION 1.3.0)

include(CTest)

include (cmake/compilers.cmake)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

add_subdirectory(src)
