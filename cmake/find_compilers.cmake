# Find and hint Fortran compiler via ENV{FC}.
# ENV{FC} is picked up by project().
# This is needed for CI GitHub Actions,
# which purposely doesn't have an alias for "gfortran"

include_guard(GLOBAL)

if(DEFINED FC OR DEFINED CMAKE_Fortran_COMPILER OR DEFINED ENV{FC})
  return()
endif()

find_program(fc
NAMES gfortran gfortran-13 gfortran-12 gfortran-11 gfortran-10
NAMES_PER_DIR
)

message(DEBUG "fc: ${fc}")

if(fc)
  set(ENV{FC} ${fc})
  message(VERBOSE "ENV{FC}: $ENV{FC}")
endif()
