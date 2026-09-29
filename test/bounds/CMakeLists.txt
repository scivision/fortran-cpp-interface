set_property(DIRECTORY PROPERTY LABELS bounds)

add_executable(bounds_fortran bounds.f90 ${PROJECT_SOURCE_DIR}/src/bounds/bounds.cpp ${PROJECT_SOURCE_DIR}/src/bounds/bounds.f90)
target_include_directories(bounds_fortran PRIVATE ${PROJECT_SOURCE_DIR}/src/bounds)
set_property(TARGET bounds_fortran PROPERTY LINKER_LANGUAGE ${linker_lang})

add_test(NAME BoundsFortran COMMAND bounds_fortran)
