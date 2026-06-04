set_property(DIRECTORY PROPERTY LABELS bounds)

if(NOT HAVE_ISO_FORTRAN_BINDING_H)
  return()
endif()

add_executable(bounds_fortran bounds.f90 ${PROJECT_SOURCE_DIR}/src/bounds/bounds.c)
target_include_directories(bounds_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/bounds)
add_test(NAME BoundsFortran COMMAND bounds_fortran)
