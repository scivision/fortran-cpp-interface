cmake_minimum_required(VERSION 3.14...3.23)

project(Fortran_C_CXX_interface
LANGUAGES C CXX Fortran
VERSION 1.3.0)

include(CTest)

include (cmake/compilers.cmake)

add_subdirectory(src)
