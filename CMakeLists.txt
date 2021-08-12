# Demonstrate linking of
# * C++ calling Fortran
# * Fortran calling C++
# * Fortran calling C
#
# https://stackoverflow.com/tags/fortran-iso-c-binding/info
#
# this also works between ABI compatible compilers
# e.g. Clang and GCC.
#
# This also works for MacOS with Apple's Clang and Homebrew GCC,
# by being sure you have in ~/.zshrc like the following:
# (check directory / versions on your Mac)
#
# export LIBRARY_PATH=$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX11.1.sdk/usr/lib
#
# export CPLUS_INCLUDE_PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX11.1.sdk/usr/include
# export CXXFLAGS=-I$CPLUS_INCLUDE_PATH
# export CFLAGS=$CXXFLAGS
#
# in general, CMake >= 3.14 have better link resolution than CMake 3.13.
cmake_minimum_required(VERSION 3.14...3.21)

project(Fortran_C_CXX_interface
LANGUAGES C Fortran CXX
VERSION 1.1.1)

include(CTest)

include (cmake/compilers.cmake)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

add_subdirectory(c)

add_subdirectory(cxx)
