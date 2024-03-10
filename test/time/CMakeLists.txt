set_property(DIRECTORY PROPERTY LABELS time)

add_executable(cxx_fortran_tictoc main.cpp clock.f90)
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

file(READ strptime.f90 src)
check_source_compiles(Fortran "${src}" HAVE_C_STRPTIME)

target_sources(strptime PRIVATE "$<$<NOT:$<BOOL:${HAVE_C_STRPTIME}>>:strptime.cpp>")

if(TARGET strftime)
  target_link_libraries(strftime PRIVATE "$<$<BOOL:${MINGW}>:ucrtbase>")
endif()
