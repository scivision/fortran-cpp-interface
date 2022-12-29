set_property(DIRECTORY PROPERTY LABELS allocate)

add_library(fancy OBJECT fancy.f90)
add_library(alloc_fortran OBJECT f_alloc.f90)

add_executable(fancy_interactive interactive.cpp $<TARGET_OBJECTS:fancy>)

add_executable(fancy_allocate intel.cpp $<TARGET_OBJECTS:fancy>)
add_test(NAME FancyAllocate COMMAND fancy_allocate)

add_executable(cpp_fortran_allocate main.cpp $<TARGET_OBJECTS:alloc_fortran>)
add_test(NAME C++_Fortran_allocate COMMAND cpp_fortran_allocate)

add_executable(c_fortran_allocate main.c $<TARGET_OBJECTS:alloc_fortran>)
# LINKER_LANGUAGE option is necessary for Linux oneAPI
set_property(TARGET c_fortran_allocate PROPERTY LINKER_LANGUAGE C)
add_test(NAME C_Fortran_allocate COMMAND c_fortran_allocate)

if(CMAKE_Fortran_COMPILER_ID STREQUAL "Cray" OR CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  set_property(TEST C++_Fortran_allocate C_Fortran_allocate PROPERTY SKIP_RETURN_CODE 77)
endif()
