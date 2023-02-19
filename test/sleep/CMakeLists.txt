set_property(DIRECTORY PROPERTY LABELS sleep)

add_library(f_sleep OBJECT ${PROJECT_SOURCE_DIR}/src/sleep/sleep_std.f90)

add_library(c_f_sleep ${PROJECT_SOURCE_DIR}/src/sleep/sleep.c)
target_link_libraries(c_f_sleep PRIVATE f_sleep)
add_library(cpp_f_sleep ${PROJECT_SOURCE_DIR}/src/sleep/sleep.cpp)
target_link_libraries(cpp_f_sleep PRIVATE f_sleep)

add_executable(fortran_c_sleep test_sleep.f90)
target_link_libraries(fortran_c_sleep PRIVATE c_f_sleep)
add_test(NAME Fortran_c_sleep COMMAND fortran_c_sleep)

add_executable(fortran_cpp_sleep test_sleep.f90)
target_link_libraries(fortran_cpp_sleep PRIVATE cpp_f_sleep)
add_test(NAME Fortran_cpp_sleep COMMAND fortran_cpp_sleep)

# reference -- above methods recommended instead
if(WIN32)

add_library(f_win_sleep OBJECT ${PROJECT_SOURCE_DIR}/src/sleep/reference/windows.f90)
set_property(TARGET f_win_sleep PROPERTY Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/windows)
target_include_directories(f_win_sleep PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/include/windows)
add_executable(fortran_win_sleep test_sleep.f90)
target_link_libraries(fortran_win_sleep PRIVATE f_win_sleep)
add_test(NAME Fortran_win_sleep COMMAND fortran_win_sleep)

endif()

if(NOT MSVC)

add_library(f_micro_sleep OBJECT ${PROJECT_SOURCE_DIR}/src/sleep/reference/posix_usleep.f90)
set_property(TARGET f_micro_sleep PROPERTY Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/posix_usleep)
target_include_directories(f_micro_sleep PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/include/posix_usleep)
add_executable(fortran_micro_sleep test_sleep.f90)
target_link_libraries(fortran_micro_sleep PRIVATE f_micro_sleep)
add_test(NAME Fortran_micro_sleep COMMAND fortran_micro_sleep)

add_library(f_nano_sleep OBJECT ${PROJECT_SOURCE_DIR}/src/sleep/reference/posix_nanosleep.f90)
set_property(TARGET f_nano_sleep PROPERTY Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/posix_nanosleep)
target_include_directories(f_nano_sleep PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/include/posix_nanosleep)
add_executable(fortran_nano_sleep test_sleep.f90)
target_link_libraries(fortran_nano_sleep PRIVATE f_nano_sleep)
add_test(NAME Fortran_nano_sleep COMMAND fortran_nano_sleep)
set_property(TEST Fortran_nano_sleep PROPERTY DISABLED $<BOOL:${MINGW}>)

endif()

get_property(tests DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)
set_property(TEST ${tests} PROPERTY TIMEOUT 5)
# allow extra time for valgrind. Have some timeout b/c macOS can hang for example.
