set_property(DIRECTORY PROPERTY LABELS ISO_Fortran_binding)

if(NOT HAVE_ISO_FORTRAN_BINDING_H)
  return()
endif()

if(HAVE_C_ALLOC_CHAR)
  add_executable(string_view string_view.f90 string_view.cpp)
  set_property(TARGET string_view PROPERTY LINKER_LANGUAGE Fortran)
  add_test(NAME string_view COMMAND string_view)
endif()

check_include_file_cxx(span HAVE_SPAN)

if(NOT HAVE_SPAN OR
    (CMAKE_Fortran_COMPILER_ID STREQUAL "GNU" AND
     CMAKE_Fortran_COMPILER_VERSION VERSION_LESS 12))
  set(sampling_old TRUE)
endif()

if(NOT sampling_old)
add_executable(sampling sampling.cpp sampling.f90)
set_property(TARGET sampling PROPERTY LINKER_LANGUAGE CXX)
target_compile_features(sampling PRIVATE cxx_std_20)

add_test(NAME sampling COMMAND sampling)
endif()

if(HAVE_CFI_IS_CONTIGUOUS)
  add_executable(cfi_allocate cfi_allocate.c cfi_allocate.f90)
  add_test(NAME CFI_allocate COMMAND cfi_allocate)
endif()

if(HAVE_C_CHAR_PTR)
  add_executable(cfi_establish_string c_string.f90 c_string.c)
  add_test(NAME CFI_establish_string COMMAND cfi_establish_string)

  add_executable(string_array string_array.cpp string_array.f90)
  set_property(TARGET string_array PROPERTY LINKER_LANGUAGE CXX)
  target_compile_options(string_array PRIVATE "$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-Wno-uninitialized>")
  add_test(NAME string_array COMMAND string_array)
  set_property(TEST string_array PROPERTY PASS_REGULAR_EXPRESSION
"red[ \n]+green[ \n]+blue")
endif()


add_executable(cfi_setpointer setpointer.f90 setpointer.c)
add_test(NAME CFI_setpointer COMMAND cfi_setpointer)

foreach(t IN ITEMS cfi_setpointer sampling)
  if(TARGET ${t})

    target_compile_options(${t} PRIVATE
    "$<$<AND:$<COMPILE_LANG_AND_ID:Fortran,GNU>,$<VERSION_LESS:$<Fortran_COMPILER_VERSION>,12>>:-Wno-uninitialized>"
    "$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-Wno-maybe-uninitialized>"
    )
    # GCC 13.2 on macOS needed -Wno-maybe-uninitialized
  endif()
endforeach()
