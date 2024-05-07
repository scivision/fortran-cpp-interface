
add_library(int_iterator OBJECT lib.cpp)
target_compile_features(int_iterator PUBLIC cxx_std_20)
target_include_directories(int_iterator PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(int_iterator_fortran main.f90)
target_link_libraries(int_iterator_fortran PRIVATE int_iterator)
add_test(NAME IntegerIteratorFortran COMMAND int_iterator_fortran)

add_executable(int_iterator_cpp main.cpp)
target_link_libraries(int_iterator_cpp PRIVATE int_iterator)
add_test(NAME IntegerIteratorCpp COMMAND int_iterator_cpp)

set_tests_properties(IntegerIteratorFortran IntegerIteratorCpp
  PROPERTIES DISABLED true
  )
