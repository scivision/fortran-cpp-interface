set_property(DIRECTORY PROPERTY LABELS ISO_Fortran_binding)

if(NOT HAVE_ISO_FORTRAN_BINDING_H)
  message(STATUS "Skipping CFI_allocate examples as ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION} does not have ISO_Fortran_binding.h")
  return()
endif()

add_executable(cfi_allocate cfi_allocate.c cfi_allocate.f90)
