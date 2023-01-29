set_property(DIRECTORY PROPERTY LABELS ISO_Fortran_binding)

if(NOT HAVE_ISO_FORTRAN_BINDING_H)
  message(STATUS "Skipping derived examples as ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION} does not have ISO_Fortran_binding.h")
  return()
endif()

add_executable(binding_derived derived.f90 main.c)
set_property(TARGET binding_derived PROPERTY LINKER_LANGUAGE C)
add_test(NAME binding_derived COMMAND binding_derived)
