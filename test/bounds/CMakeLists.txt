set_property(DIRECTORY PROPERTY LABELS bounds)

if(NOT HAVE_ISO_FORTRAN_BINDING_H)
  return()
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU" AND
  CMAKE_Fortran_COMPILER_VERSION VERSION_LESS 12)
    message(STATUS "GNU Fortran < 12 has known bugs in non-default array bounds. Skipping bounds tests.")
  return()
endif()

add_executable(bounds_fortran bounds.f90 ${PROJECT_SOURCE_DIR}/src/bounds/bounds.cpp)
target_include_directories(bounds_fortran PRIVATE ${PROJECT_SOURCE_DIR}/src/bounds)

add_test(NAME BoundsFortran COMMAND bounds_fortran)
