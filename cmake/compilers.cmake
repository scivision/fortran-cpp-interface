# check C and Fortran compiler ABI compatibility

if(NOT abi_ok)
  message(CHECK_START "checking that C and Fortran compilers can link")
  try_compile(abi_ok ${CMAKE_CURRENT_BINARY_DIR}/abi_check ${CMAKE_CURRENT_LIST_DIR}/abi_check abi_check)
  if(abi_ok)
    message(CHECK_PASS "OK")
  else()
    message(FATAL_ERROR "C compiler ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION} and Fortran compiler ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION} are ABI-incompatible.")
  endif()
endif()

# --- compiler options

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  # this helps show the options are/aren't conflicting between C and Fortran
  # at build time
  string(APPEND CMAKE_Fortran_FLAGS " -fimplicit-none")
  add_compile_options(-Wextra -Wall)
endif()
