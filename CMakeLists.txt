cmake_minimum_required(VERSION 3.25...3.27)
# 3.15+ for COMPILE_LANGAGE multiple languages, COMPILE_LANG_AND_ID
# 3.25+ for block()

project(Fortran_C_CXX_interface
LANGUAGES C CXX Fortran
)

enable_testing()

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 14)

include(cmake/options.cmake)
include(cmake/compilers.cmake)

foreach(a IN ITEMS
  allocate cfi_allocate cfi_establish cfi_setpointer
  contiguous
  array bool error
  glibc malloc
  opaque pointer poly_function poly_type struct
  sleep string submodule
  time vector)
  add_subdirectory(test/${a})
endforeach()
