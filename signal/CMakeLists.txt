add_library(c_sigint OBJECT c_interface.c)

add_library(c_ifc OBJECT c_interface.F90)

add_executable(waitForSIGINT $<TARGET_OBJECTS:c_sigint> $<TARGET_OBJECTS:c_ifc>)
if(WIN32)
  target_sources(waitForSIGINT PRIVATE main_windows.f90)
else()
  target_sources(waitForSIGINT PRIVATE main_unix.f90)
endif()
