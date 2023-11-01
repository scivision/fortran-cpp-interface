include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckSourceCompiles)

# --- abi check: C++ and Fortran compiler ABI compatibility

function(abi_check)
if(NOT abi_compile)

  message(CHECK_START "checking that C, C++, and Fortran compilers can link")
  try_compile(abi_compile
  ${CMAKE_CURRENT_BINARY_DIR}/abi_compile ${CMAKE_CURRENT_LIST_DIR}/abi_check
  abi_check
  OUTPUT_VARIABLE abi_output
  )
  if(abi_output MATCHES "ld: warning: could not create compact unwind for")
    message(WARNING "C++ exception handling will not work reliably due to incompatible compilers:
    C++ compiler ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}
    Fortran compiler ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}"
    )
  endif()

if(abi_compile)
  message(CHECK_PASS "OK")
else()
  message(FATAL_ERROR "ABI-incompatible compilers:
  C compiler ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}
  C++ compiler ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}
  Fortran compiler ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}"
  )
endif()
endif()

if(NOT abi_run EQUAL 0)

message(CHECK_START "checking that C++ exception handling works from Fortran")
try_run(abi_run abi_compile_run
  ${CMAKE_CURRENT_BINARY_DIR}/abi_run
  SOURCES ${PROJECT_SOURCE_DIR}/test/exception/exception.f90
    ${PROJECT_SOURCE_DIR}/test/exception/raise_exception.cpp
)

if(abi_compile_run AND abi_run EQUAL 0)
  message(CHECK_PASS "OK")
else()
  message(WARNING "Exception handling failed: return code ${abi_run} using compilers:
  C compiler ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}
  C++ compiler ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}
  Fortran compiler ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_Fortran_COMPILER_VERSION}"
  )
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

# --- GCC < 12 can't do this
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
