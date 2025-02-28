set_property(DIRECTORY PROPERTY LABELS nullptr)

add_library(c_nullptr OBJECT lib.c)
target_include_directories(c_nullptr PRIVATE .)
add_library(cpp_nullptr OBJECT lib.cpp)
target_include_directories(cpp_nullptr PRIVATE .)

add_executable(C_Fortran_nullptr main.f90 $<TARGET_OBJECTS:c_nullptr>)
add_test(NAME C_Nullptr COMMAND C_Fortran_nullptr)

add_executable(Cpp_Fortran_nullptr main.f90 $<TARGET_OBJECTS:cpp_nullptr>)
set_property(TARGET Cpp_Fortran_nullptr PROPERTY LINKER_LANGUAGE ${linker_lang})

add_test(NAME Cpp_Nullptr COMMAND Cpp_Fortran_nullptr)
