cmake_minimum_required(VERSION 3.19...3.30)
# 3.19 for CheckSourceCompiles

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "Please use out-of-source build:
  cmake -Bbuild")
endif()

project(Fortran_C_CXX_interface
LANGUAGES C CXX Fortran
)

enable_testing()

include(CheckSourceCompiles)

set(CMAKE_CXX_SCAN_FOR_MODULES OFF)
# This project isn't using C++ modules; avoid bugs in module scanning CMake 3.28, 3.29 with GCC >= 14.

set(CMAKE_C_STANDARD 99)

set(CMAKE_CXX_STANDARD 20)
# we use c++20 features in some examples

message(STATUS "${PROJECT_NAME} CMake ${CMAKE_VERSION}")

foreach(c IN ITEMS f03abstract f03bind
  f08contiguous f08submod_bind)
  include(cmake/${c}.cmake)
endforeach()

include(cmake/compilers.cmake)

option(cppcheck "Run cppcheck")

# CPPcheck
if(cppcheck)
  find_program(cppcheck_exe NAMES cppcheck REQUIRED)
  set(cppcheck_opts --enable=all --inline-suppr --quiet --suppressions-list=${PROJECT_SOURCE_DIR}/cppcheck.supp)
  set(CMAKE_C_CPPCHECK ${cppcheck_exe} --std=c${CMAKE_C_STANDARD} ${cppcheck_opts})
  set(CMAKE_CXX_CPPCHECK ${cppcheck_exe} --std=c++${CMAKE_CXX_STANDARD} ${cppcheck_opts})
endif()

# Targets

foreach(a IN ITEMS
  iso_fortran_binding
  allocate contiguous
  array bool error exception
  iterator
  glibc malloc
  opaque pointer poly_function poly_type real struct
  sleep string submodule
  time vector)

  add_subdirectory(test/${a})

endforeach()

file(GENERATE OUTPUT .gitignore CONTENT "*")
