set_property(DIRECTORY PROPERTY LABELS ISO_Fortran_binding)

if(NOT HAVE_CFI_IS_CONTIGUOUS)
  message(STATUS "Skipping CFI_allocate examples as missing CFI_is_contiguous()")
  return()
endif()

add_executable(cfi_allocate cfi_allocate.c cfi_allocate.f90)
add_test(NAME CFI_allocate COMMAND cfi_allocate)
