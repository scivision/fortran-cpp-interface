# check C and Fortran compiler ABI compatibility

try_compile(abi_ok ${CMAKE_CURRENT_BINARY_DIR}/abi_check ${CMAKE_CURRENT_LIST_DIR}/abi_check abi_check)
if(abi_ok)
  message(STATUS "C and Fortran compiler detected to be ABI-compatible.")
else()
  message(FATAL ERROR "C compiler {CMAKE_C_COMPILER_ID} {CMAKE_C_COMPILER_VERSION} and Fortran compiler ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION} are ABI-incompatible.")
endif()


if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  # this helps show the options are/aren't conflicting between C and Fortran
  # at build time
  string(APPEND CMAKE_Fortran_FLAGS -fimplicit-none)
  add_compile_options(-Wextra)
endif()

add_compile_options(-Wall)
