cmake_minimum_required(VERSION 3.19...3.28)
# 3.15+ for COMPILE_LANGAGE multiple languages, COMPILE_LANG_AND_ID
# 3.19 for CheckSourceCompiles

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "Please use out-of-source build:
  cmake -Bbuild")
endif()

project(Fortran_C_CXX_interface
LANGUAGES C CXX Fortran
)

enable_testing()

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 14)

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
  allocate cfi_allocate cfi_establish cfi_setpointer
  contiguous
  array bool error exception
  glibc malloc
  opaque pointer poly_function poly_type struct
  sleep string submodule
  time vector)
  add_subdirectory(test/${a})
endforeach()


message(STATUS "${PROJECT_NAME} ${PROJECT_VERSION}  CMake ${CMAKE_VERSION}")

# Necessary for shared library with Visual Studio / Windows oneAPI
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS true)

file(GENERATE OUTPUT .gitignore CONTENT "*")
