cmake_minimum_required(VERSION 3.19)

project(Fortran_C_CXX_interface
LANGUAGES C CXX Fortran
)

include(CTest)

include (cmake/compilers.cmake)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

foreach(d allocate array bool error malloc opaque pointer poly_function poly_type struct submodule tictoc vector)
  set(td src/${d})
  add_subdirectory(${td})
  get_property(targets DIRECTORY ${td} PROPERTY BUILDSYSTEM_TARGETS)

  foreach(t IN LISTS targets)
    target_compile_features(${t} PRIVATE c_std_99)
    target_compile_features(${t} PRIVATE cxx_std_11)
  endforeach()
endforeach()
