if(DEFINED f08submod_bind)
  return()
endif()

block()

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

endblock()
