
add_library(int_iterator OBJECT lib.cpp)
set_property(TARGET int_iterator PROPERTY CXX_STANDARD 14)
target_include_directories(int_iterator PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(int_iterator_fortran main.f90)
target_link_libraries(int_iterator_fortran PRIVATE int_iterator)
add_test(NAME IntegerIteratorFortran COMMAND int_iterator_fortran)

add_executable(int_iterator_cpp main.cpp)
target_link_libraries(int_iterator_cpp PRIVATE int_iterator)
add_test(NAME IntegerIteratorCpp COMMAND int_iterator_cpp)
