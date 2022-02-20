add_library(vector_cxx OBJECT vector_lib.cxx)

add_library(struct_cxx OBJECT struct_lib.cxx)
target_include_directories(struct_cxx PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../c)

add_library(error_cxx OBJECT error_lib.cxx)
