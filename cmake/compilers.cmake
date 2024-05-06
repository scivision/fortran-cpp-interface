include(CheckIncludeFile)
include(CheckSymbolExists)

# --- abi check: C++ and Fortran compiler ABI compatibility

function(abi_check)
if(NOT DEFINED abi_compile)

  message(CHECK_START "checking that C, C++, and Fortran compilers can link")
  try_compile(abi_compile ${CMAKE_CURRENT_BINARY_DIR}/abi_compile ${CMAKE_CURRENT_LIST_DIR}/abi_check abi_check)

if(abi_compile)
  message(CHECK_PASS "OK")
else()
  message(FATAL_ERROR "ABI-incompatible compilers:
  C compiler ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}
  C++ compiler ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}
  Fortran compiler ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}"
  )
endif()

# try_run() doesn't adequately detect failed exception handling--it may pass while ctest of the same exe fails
if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.25)
  message(CHECK_START "checking that C++ exception handling works")
  try_compile(exception_compile
    PROJECT exception
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/exception_check
    OUTPUT_VARIABLE abi_output
  )
  if(abi_output MATCHES "ld: warning: could not create compact unwind for")
    message(CHECK_FAIL "no")
    set(HAVE_CXX_TRYCATCH false CACHE BOOL "C++ exception handling broken")
    message(WARNING "C++ exception handling will not work reliably due to incompatible compilers")
  else()
    message(CHECK_PASS "yes")
    set(HAVE_CXX_TRYCATCH true CACHE BOOL "C++ exception handling works")
  endif()
endif()

endif()


endfunction(abi_check)
abi_check()


# --- ISO_Fortran_binding.h header
function(check_iso_fortran_binding)
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

endfunction()
check_iso_fortran_binding()

# --- GCC < 12 can't do these
check_source_compiles(Fortran
"program cstr
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
)

check_source_compiles(Fortran
"program string_view
use, intrinsic :: iso_c_binding, only : c_char
implicit none
interface
subroutine echo_c( str ) bind(C)
import :: c_char
character(kind=c_char, len=:), allocatable, intent(in) :: str
end subroutine
end interface
end program"
HAVE_C_ALLOC_CHAR
)

# --- fix errors about needing -fPIE
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  include(CheckPIESupported)
  check_pie_supported()
  set(CMAKE_POSITION_INDEPENDENT_CODE true)
endif()

# --- compiler options

if(CMAKE_C_COMPILER_ID MATCHES "Clang|GNU|^Intel")
  add_compile_options(
  "$<$<AND:$<COMPILE_LANGUAGE:C,CXX>,$<CONFIG:Debug>>:-Wextra>"
  "$<$<COMPILE_LANGUAGE:C,CXX>:-Wall;-Werror=array-bounds>"
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

# "$<$<COMPILE_LANGUAGE:Fortran>:-Werror=array-bounds;-fcheck=all>"

elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
add_compile_options(
"$<$<COMPILE_LANGUAGE:Fortran>:-warn>"
"$<$<COMPILE_LANGUAGE:Fortran>:-standard-semantics>"
"$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug,RelWithDebInfo>>:-traceback;-check;-debug>"
$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-O0>
)
# https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2024-1/standard-semantics.html
endif()
