set_property(DIRECTORY PROPERTY LABELS time)

add_library(fortran_clock OBJECT clock.f90)
add_executable(cxx_fortran_tictoc main.cpp $<TARGET_OBJECTS:fortran_clock>)
add_test(NAME C++_Fortran_tictoc COMMAND cxx_fortran_tictoc)

file(READ strftime.f90 src)
check_source_compiles(Fortran "${src}" HAVE_C_STRFTIME)

set(tests strptime)
if(HAVE_C_STRFTIME)
  list(APPEND tests strftime)
endif()

foreach(t IN LISTS tests)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()

set(CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)
check_symbol_exists(strptime "time.h" HAVE_C_STRPTIME)

if(NOT HAVE_C_STRPTIME)
  add_library(cpp_strptime OBJECT strptime.cpp)
  target_sources(strptime PRIVATE $<TARGET_OBJECTS:cpp_strptime>)
endif()

if(TARGET strftime)
  target_link_libraries(strftime PRIVATE "$<$<BOOL:${MINGW}>:ucrtbase>")
endif()
