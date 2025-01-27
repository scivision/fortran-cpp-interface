set_property(DIRECTORY PROPERTY LABELS pointer)

add_library(pointer_fortran ${PROJECT_SOURCE_DIR}/src/pointer/pmod.f90)
target_include_directories(pointer_fortran INTERFACE ${PROJECT_SOURCE_DIR}/src/pointer)

if(f03bind)

add_executable(fortran_pointer_lubound pointer_bounds.f90)
add_test(NAME Fortran_pointer_lubound COMMAND fortran_pointer_lubound)

endif()

add_executable(c_fortran_pointer main.c)
target_link_libraries(c_fortran_pointer PRIVATE pointer_fortran)
add_test(NAME C_Fortran_pointer COMMAND c_fortran_pointer)

add_executable(cxx_fortran_pointer main.cpp)
target_link_libraries(cxx_fortran_pointer PRIVATE pointer_fortran)
add_test(NAME C++_Fortran_pointer COMMAND cxx_fortran_pointer)

add_library(cpp_null OBJECT ${PROJECT_SOURCE_DIR}/src/pointer/null.cpp)
add_executable(fortran_cxx_null null_c.f90 $<TARGET_OBJECTS:cpp_null>)
set_property(TARGET fortran_cxx_null PROPERTY LINKER_LANGUAGE ${linker_lang})
add_test(NAME Fortran_C++_null COMMAND fortran_cxx_null)

# for Visual Studio generator object library
add_library(c_null OBJECT ${PROJECT_SOURCE_DIR}/src/pointer/null.c)
add_executable(fortran_c_null null_c.f90 $<TARGET_OBJECTS:c_null>)
add_test(NAME Fortran_C_null COMMAND fortran_c_null)

set_property(TARGET fortran_c_null fortran_cxx_null PROPERTY LINKER_LANGUAGE Fortran)
