set_property(DIRECTORY PROPERTY LABELS allocate)

add_library(fancy OBJECT ${PROJECT_SOURCE_DIR}/src/allocate/fancy.f90)
target_include_directories(fancy INTERFACE ${PROJECT_SOURCE_DIR}/src/allocate)

add_library(alloc_fortran ${PROJECT_SOURCE_DIR}/src/allocate/f_alloc.f90)
target_include_directories(alloc_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/allocate)

add_executable(fancy_interactive ${PROJECT_SOURCE_DIR}/app/allocate/interactive.cpp)
target_link_libraries(fancy_interactive PRIVATE fancy)

add_executable(fancy_allocate ${PROJECT_SOURCE_DIR}/app/allocate/intel.cpp)
target_link_libraries(fancy_allocate PRIVATE fancy)
add_test(NAME FancyAllocate COMMAND fancy_allocate)

add_executable(cpp_fortran_allocate ${PROJECT_SOURCE_DIR}/app/allocate/main.cpp)
target_link_libraries(cpp_fortran_allocate PRIVATE alloc_fortran)
add_test(NAME C++_Fortran_allocate COMMAND cpp_fortran_allocate)

add_executable(c_fortran_allocate ${PROJECT_SOURCE_DIR}/app/allocate/main.c)
target_link_libraries(c_fortran_allocate PRIVATE alloc_fortran)
add_test(NAME C_Fortran_allocate COMMAND c_fortran_allocate)

if(CMAKE_Fortran_COMPILER_ID STREQUAL "Cray" OR CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  set_property(TEST C++_Fortran_allocate C_Fortran_allocate PROPERTY SKIP_RETURN_CODE 77)
endif()
