set_property(DIRECTORY PROPERTY LABELS uid)

add_library(uid_cpp OBJECT ${PROJECT_SOURCE_DIR}/src/uid/uid.cpp)
target_link_libraries(uid_cpp PUBLIC $<$<BOOL:${WIN32}>:Advapi32>)

add_executable(getuid getuid.f90)
target_link_libraries(getuid PRIVATE uid_cpp)
set_property(TARGET getuid PROPERTY LINKER_LANGUAGE ${linker_lang})

add_test(NAME GetUID COMMAND getuid)
