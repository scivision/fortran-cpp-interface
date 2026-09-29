set_property(DIRECTORY PROPERTY LABELS rank)

add_executable(get_cfi_max_rank cfi_max_rank.f90 ${PROJECT_SOURCE_DIR}/src/rank/cfi_max_rank.c)

add_test(NAME CFI_MAX_RANK COMMAND get_cfi_max_rank)
