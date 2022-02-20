subdir('c')

subdir('cxx')

subdir('fortran')

# -- Fortran calling C++
fortran_cxx_vector = executable('fortran_cxx_vector',
sources: files('fortran/vector_main.f90'),
link_with: vector_cxx,
dependencies: cstdlib,
link_language: 'fortran'
)
test('Fortran C++ vector', fortran_cxx_vector, timeout: 5)

fortran_cxx_struct = executable('fortran_cxx_struct',
sources: files('fortran/struct_main.f90'),
include_directories: 'c',
link_with: struct_cxx,
dependencies: cstdlib,
link_language: 'fortran'
)
test('Fortran C++ struct', fortran_cxx_struct,  timeout: 5)

fortran_cxx_err = executable('fortran_cxx_err',
sources: files('fortran/error_main.f90'),
link_with: error_cxx,
dependencies: cstdlib,
link_language: 'fortran'
)
test('Fortran C++ error', fortran_cxx_err,
timeout: 5,
should_fail: true)

# -- Fortran calling C
fortran_c_vector = executable('fortran_c_vector',
sources: files('fortran/vector_main.f90'),
link_with: vector_c,
link_language: 'fortran'
)
test('Fortran C vector', fortran_c_vector,  timeout: 5)

fortran_c_struct = executable('fortran_c_struct',
sources: files('fortran/struct_main.f90'),
link_with: struct_c,
link_language: 'fortran'
)
test('Fortran C struct', fortran_c_struct,  timeout: 5)

fortran_c_err = executable('fortran_c_err',
sources: files('fortran/error_main.f90'),
link_with: error_c,
link_language: 'fortran'
)
test('Fortran C error', fortran_c_err,
timeout: 5,
should_fail: true)

# -- C calling Fortran
c_fortran_submod = executable('c_fortran_submodule',
sources: files('c/submodule_main.c'),
link_with: submodule_fortran,
link_language: 'fortran'
)
test('C Fortran Submodule', c_fortran_submod, timeout: 5)

c_fortran_error = executable('c_fortran_error',
sources: files('c/error_main.c'),
link_with: error_fortran,
link_language: 'fortran'
)
test('C Fortran error', c_fortran_error,
timeout: 5,
should_fail: true
)

c_fortran_struct = executable('c_fortran_struct',
sources: files('c/struct_main.c'),
link_with: struct_fortran,
link_language: 'fortran'
)
test('C Fortran struct', c_fortran_struct, timeout: 5)

# -- C++ calling Fortran
cxx_fortran_submod = executable('cxx_fortran_submodule',
sources: files('cxx/submodule_main.cxx'),
link_with: submodule_fortran,
cpp_args: '-D_USE_MATH_DEFINES'
)
test('C++ Fortran Submodule', cxx_fortran_submod, timeout: 5)

cxx_fortran_array = executable('cxx_fortran_array',
sources: files('cxx/array_main.cxx'),
link_with: vector_fortran
)
test('C++ Fortran Array', cxx_fortran_array, timeout: 5)

cxx_fortran_vector = executable('cxx_fortran_vector',
sources: files('cxx/vector_main.cxx'),
link_with: vector_fortran
)
test('C++ Fortran Vector', cxx_fortran_vector, timeout: 5)

cxx_fortran_error = executable('cxx_fortran_error',
sources: files('cxx/error_main.cxx'),
link_with: error_fortran,
link_language: 'fortran'
)
test('C++ Fortran error', cxx_fortran_error,
timeout: 5,
should_fail: true
)

cxx_fortran_struct = executable('cxx_fortran_struct',
sources: files('cxx/struct_main.cxx'),
include_directories: 'c',
link_with: struct_fortran,
link_language: 'fortran'
)
test('C++ Fortran struct', cxx_fortran_struct,
timeout: 5
)
