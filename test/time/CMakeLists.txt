set_property(DIRECTORY PROPERTY LABELS tictoc)

add_executable(cxx_fortran_tictoc main.cpp clock.f90)
add_test(NAME C++_Fortran_tictoc COMMAND cxx_fortran_tictoc)

foreach(t IN ITEMS strftime strptime)
  add_executable(${t} ${t}.f90)
  add_test(NAME ${t} COMMAND ${t})
endforeach()

file(READ strptime.f90 src)
check_fortran_source_compiles("${src}" HAVE_C_STRPTIME SRC_EXT f90)

target_sources(strptime PRIVATE "$<$<NOT:$<BOOL:${HAVE_C_STRPTIME}>>:strptime.cpp>")

target_link_libraries(strftime PRIVATE "$<$<BOOL:${MINGW}>:ucrtbase>")
