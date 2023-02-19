include(CheckIncludeFile)
include(CheckFortranSourceCompiles)

# check C and Fortran compiler ABI compatibility

if(NOT abi_ok)
  message(CHECK_START "checking that C, C++, and Fortran compilers can link")
  try_compile(abi_ok
  ${CMAKE_CURRENT_BINARY_DIR}/abi_check ${CMAKE_CURRENT_LIST_DIR}/abi_check
  abi_check
  OUTPUT_VARIABLE abi_log
  )
  if(abi_ok)
    message(CHECK_PASS "OK")
  else()
    message(FATAL_ERROR "ABI-incompatible compilers:
    C compiler ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}
    C++ compiler ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}
    Fortran compiler ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}
    ${abi_log}
    "
    )
  endif()
endif()

# --- ISO_Fortran_binding.h header
check_include_file("ISO_Fortran_binding.h" HAVE_ISO_FORTRAN_BINDING_H)

# --- GCC < 12 can't do this
check_fortran_source_compiles("
program cstr
use, intrinsic :: iso_c_binding, only : c_char
implicit none
interface
subroutine fun(s) bind(C)
import :: c_char
character(kind=c_char, len=:), pointer, intent(out) :: s
end subroutine
end interface
end program
"
HAVE_C_CHAR_PTR
SRC_EXT f90
)

# --- fix errors about needing -fPIE
if(CMAKE_SYSTEM_NAME STREQUAL "Linux" AND CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  set(CMAKE_POSITION_INDEPENDENT_CODE true)
endif()

# --- compiler options

if(CMAKE_C_COMPILER_ID MATCHES "Clang|GNU|^Intel")
  add_compile_options(
  "$<$<AND:$<COMPILE_LANGUAGE:C,CXX>,$<CONFIG:Debug>>:-Wextra>"
  "$<$<COMPILE_LANGUAGE:C,CXX>:-Wall>"
  "$<$<COMPILE_LANGUAGE:C>:-Werror=implicit-function-declaration>"
  )
elseif(CMAKE_C_COMPILER_ID MATCHES "MSVC")
  add_compile_options("$<$<COMPILE_LANGUAGE:C,CXX>:/W3>")
endif()


if(CMAKE_Fortran_COMPILER_ID STREQUAL "Cray")

add_compile_options("$<$<COMPILE_LANGUAGE:Fortran>:-eI>")

elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")

add_compile_options(-Wall -Wextra
"$<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none>"
"$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Release>>:-fno-backtrace>"
)

elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
add_compile_options(
"$<$<COMPILE_LANGUAGE:Fortran>:-warn>"
"$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug,RelWithDebInfo>>:-traceback;-check;-debug>"
$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-O0>
)
endif()
