include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckFortranSourceCompiles)

# check C and Fortran compiler ABI compatibility

if(NOT abi_ok)
  message(CHECK_START "checking that C, C++, and Fortran compilers can link")
  try_compile(abi_ok
  ${CMAKE_CURRENT_BINARY_DIR}/abi_check ${CMAKE_CURRENT_LIST_DIR}/abi_check
  abi_check
  )
  if(abi_ok)
    message(CHECK_PASS "OK")
  else()
    message(FATAL_ERROR "ABI-incompatible compilers:
    C compiler ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}
    C++ compiler ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}
    Fortran compiler ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}"
    )
  endif()
endif()

# --- ISO_Fortran_binding.h header
block()
check_include_file("ISO_Fortran_binding.h" HAVE_ISO_FORTRAN_BINDING_H)

# here we assume C and Fortran compilers are from the same vendor
# otherwise, we'd need to use try_compile() with a project for each symbol
# IntelLLVM didn't need this trick
if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
  set(CMAKE_REQUIRED_LIBRARIES "gfortran")
elseif(CMAKE_C_COMPILER_ID STREQUAL "NVHPC")
  set(CMAKE_REQUIRED_LIBRARIES "nvf")
endif()

# some compilers (e.g. NVHPC) have ISO_Fortran_binding.h but don't
# have all the functions
if(HAVE_ISO_FORTRAN_BINDING_H)
check_symbol_exists(CFI_is_contiguous "ISO_Fortran_binding.h" HAVE_CFI_IS_CONTIGUOUS)
check_symbol_exists(CFI_setpointer "ISO_Fortran_binding.h" HAVE_CFI_SETPOINTER)
endif()

endblock()

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

if(CMAKE_C_COMPILER_ID MATCHES "^Intel")
  add_compile_options("$<$<AND:$<COMPILE_LANGUAGE:C,CXX>,$<CONFIG:Debug>>:-Rno-debug-disables-optimization>")
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
