set_property(DIRECTORY PROPERTY LABELS uid)

add_executable(getuid getuid.f90 ${PROJECT_SOURCE_DIR}/src/uid/uid.cpp)
set_property(TARGET getuid PROPERTY LINKER_LANGUAGE ${linker_lang})

add_test(NAME GetUID COMMAND getuid)
