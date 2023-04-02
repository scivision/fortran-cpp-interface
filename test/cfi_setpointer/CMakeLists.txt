set_property(DIRECTORY PROPERTY LABELS ISO_Fortran_binding)

if(NOT HAVE_CFI_SETPOINTER)
  message(STATUS "Skipping CFI_setpointer examples")
  return()
endif()

add_executable(cfi_setpointer main.f90 lib.c)
add_test(NAME CFI_setpointer COMMAND cfi_setpointer)
if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  # this bug was introduced in GCC 12. At least 12.1 and 12.2 are broken.
  set(CMAKE_REQUIRED_FLAGS "-Werror")
  file(READ main.f90 src)
  check_fortran_source_compiles("${src}"
  HAVE_NO_MAYBE_UNINITIALIZED
  SRC_EXT f90
  )
  target_compile_options(cfi_setpointer PRIVATE
  "$<$<NOT:$<BOOL:${HAVE_NO_MAYBE_UNINITIALIZED}>>:-Wno-maybe-uninitialized>"
  )
endif()
