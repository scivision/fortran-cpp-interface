set_property(DIRECTORY PROPERTY LABELS glibc)

if(WIN32)
  message(STATUS "skipping glibc tests since they're not for Windows")
endif()

add_executable(getuid getuid.f90)
add_test(NAME GetUID COMMAND getuid)