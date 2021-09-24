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

add_compile_options(
"$<$<COMPILE_LANG_AND_ID:C,GNU>:-mtune=native;-Wall;-Wextra>"
"$<$<COMPILE_LANG_AND_ID:CXX,GNU>:-mtune=native;-Wall;-Wextra>"
"$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-mtune=native;-Wall;-Wextra;-fimplicit-none>"
"$<$<AND:$<COMPILE_LANG_AND_ID:Fortran,GNU>,$<CONFIG:Release>>:-fno-backtrace;-Wno-maybe-uninitialized>"
"$<$<AND:$<COMPILE_LANG_AND_ID:Fortran,GNU>,$<CONFIG:RelWithDebInfo>>:-Wno-maybe-uninitialized>"

)

if(NOT EXISTS ${PROJECT_BINARY_DIR}/.gitignore)
  file(WRITE ${PROJECT_BINARY_DIR}/.gitignore "*")
endif()
