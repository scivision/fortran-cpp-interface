set_property(DIRECTORY PROPERTY LABELS nullptr)

block()
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_C_STANDARD 23)
# test has nullptr_t otherwise you're testing for a macro but not the type
check_source_compiles(C "#include <stddef.h>
nullptr_t p = nullptr;"
c23_nullptr
)
endblock()

if(c23_nullptr)
add_library(c_nullptr OBJECT lib.c)
target_include_directories(c_nullptr PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_features(c_nullptr PRIVATE c_std_23)
endif()

add_library(cpp_nullptr OBJECT lib.cpp)
target_include_directories(cpp_nullptr PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

if(TARGET c_nullptr)
add_executable(C_Fortran_nullptr main.f90 $<TARGET_OBJECTS:c_nullptr>)
add_test(NAME C_Nullptr COMMAND C_Fortran_nullptr)
endif()

add_executable(Cpp_Fortran_nullptr main.f90 $<TARGET_OBJECTS:cpp_nullptr>)
set_property(TARGET Cpp_Fortran_nullptr PROPERTY LINKER_LANGUAGE ${linker_lang})

add_test(NAME Cpp_Nullptr COMMAND Cpp_Fortran_nullptr)
