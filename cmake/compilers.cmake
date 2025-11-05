include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckIncludeFileCXX)

if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.24 AND CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang" AND CMAKE_GENERATOR STREQUAL "Unix Makefiles")
  # otherwise failed to link since -lc++ is missing
  set(linker_lang CXX)
elseif(NOT CMAKE_GENERATOR MATCHES "Visual Studio")
  # IntelLLVM|NVHPC need Fortran.
  # For other compilers (except as above) don't need it set, but Fortran doesn't hurt.
  set(linker_lang Fortran)
endif()

# --- abi check: C++ and Fortran compiler ABI compatibility

if(NOT DEFINED abi_compile)

message(CHECK_START "checking that C, C++, and Fortran compilers can link")

try_compile(abi_compile
PROJECT abi_check
SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/abi_check
CMAKE_FLAGS -Dlinker_lang=${linker_lang} -DCMAKE_LINK_WARNING_AS_ERROR:BOOL=on
)

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

message(CHECK_START "checking that C++ exception handling works")

try_compile(HAVE_CXX_TRYCATCH
  PROJECT exception
  SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/exception_check
  OUTPUT_VARIABLE _out
  CMAKE_FLAGS "-DCMAKE_LINK_WARNING_AS_ERROR:BOOL=on"
)
# _out is for CMake < 4.0

if(NOT HAVE_CXX_TRYCATCH OR _out MATCHES "ld: warning: could not create compact unwind for")
  message(CHECK_FAIL "no")
  message(WARNING "C++ exception handling will not work reliably due to incompatible compilers")
else()
  message(CHECK_PASS "yes")
endif()

endif()


# --- ISO_Fortran_binding.h header
block()

check_include_file("ISO_Fortran_binding.h" HAVE_ISO_FORTRAN_BINDING_H)

# here we assume C and Fortran compilers are from the same vendor
# otherwise, we'd need to use try_compile() with a project for each symbol
# IntelLLVM didn't need this trick
if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
  set(CMAKE_REQUIRED_LIBRARIES gfortran)
elseif(CMAKE_C_COMPILER_ID STREQUAL "NVHPC")
  set(CMAKE_REQUIRED_LIBRARIES nvf)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "LLVMFlang")
  set(CMAKE_REQUIRED_LIBRARIES FortranRuntime FortranDecimal)
endif()

# some compilers (e.g. NVHPC) have ISO_Fortran_binding.h but don't
# have all the functions
if(HAVE_ISO_FORTRAN_BINDING_H)
  check_symbol_exists(CFI_is_contiguous "ISO_Fortran_binding.h" HAVE_CFI_IS_CONTIGUOUS)
  check_symbol_exists(CFI_setpointer "ISO_Fortran_binding.h" HAVE_CFI_SETPOINTER)

  # some compilers allow using CFI_CDESC_T as a pointer but are missing the properties of it.
  check_source_compiles(C "#include <ISO_Fortran_binding.h>
  int main(void){
  CFI_CDESC_T(1) t;
  char* s = (char*) t.base_addr;
  return 0;
  }"
  HAVE_CFI_CDESC
  )
endif()

endblock()


check_source_compiles(Fortran
"program test
implicit none
real :: a(1)
print '(L1)', is_contiguous(a)
end program"
f08contiguous
)

include(${CMAKE_CURRENT_LIST_DIR}/f08submod_bind.cmake)


block()

set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

check_source_compiles(Fortran
"subroutine fun(i) bind(C)
use, intrinsic :: iso_c_binding
integer(C_INT), intent(in) :: i
end subroutine"
f03bind
)


# --- GCC < 12 can't do these
check_source_compiles(Fortran
"subroutine fun(s) bind(C)
use, intrinsic :: iso_c_binding
character(kind=c_char, len=:), pointer, intent(out) :: s
end subroutine"
HAVE_C_CHAR_PTR
)

check_source_compiles(Fortran
"subroutine echo_c( str ) bind(C)
use, intrinsic :: iso_c_binding
character(kind=c_char, len=:), allocatable, intent(in) :: str
end subroutine"
HAVE_C_ALLOC_CHAR
)

endblock()

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
"$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug,RelWithDebInfo>>:-traceback;-check;-debug>"
$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-O0>
)

# -fpscomp logicals is required for C_BOOL
if(NOT WIN32)
  add_compile_options("$<$<COMPILE_LANGUAGE:Fortran>:-fpscomp;logicals>")
endif()

# -stand f18 is just for warnings, it doesn't change compiler behavior

# DO NOT USE -standard-semantics as it breaks linkage with any other library
# including IntelMPI!
#"$<$<COMPILE_LANGUAGE:Fortran>:-standard-semantics>"

# https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2024-1/standard-semantics.html

elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "NVHPC")
  add_compile_options("$<$<COMPILE_LANGUAGE:Fortran>:-Munixlogical>")
endif()
