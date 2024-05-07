
add_library(int_iterator OBJECT lib.cpp)
target_compile_features(int_iterator PUBLIC cxx_std_20)
target_include_directories(int_iterator PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# glitch in arm64 GitHub Actions. Happened on other projects too (h5fortran-mpi)
if(NOT (APPLE AND "$ENV{GITHUB_ACTIONS}"))
add_executable(int_iterator_fortran main.f90)
target_link_libraries(int_iterator_fortran PRIVATE int_iterator)
set_property(TARGET int_iterator_fortran PROPERTY LINKER_LANGUAGE Fortran)
add_test(NAME IntegerIteratorFortran COMMAND int_iterator_fortran)
endif()

add_executable(int_iterator_cpp main.cpp)
target_link_libraries(int_iterator_cpp PRIVATE int_iterator)
add_test(NAME IntegerIteratorCpp COMMAND int_iterator_cpp)

get_property(tests DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
# in work, may not be correct algorithms
set_tests_properties(${tests} PROPERTIES DISABLED true)
