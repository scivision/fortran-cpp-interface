function(f08submod)

if(DEFINED f08submod_bind OR CMAKE_VERSION VERSION_LESS 3.25)
  return()
endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

message(CHECK_START "Checking Fortran 2008 submodule bind(C) support")

try_compile(f08submod_bind
SOURCES ${PROJECT_SOURCE_DIR}/src/submodule/bindmod.f90
)

if(f08submod_bind)
  message(CHECK_PASS "yes")
else()
  message(CHECK_FAIL "no")
endif()

endfunction()

f08submod()
