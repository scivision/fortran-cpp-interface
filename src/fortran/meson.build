vector_fortran = library('vector_fortran', 'vector_lib.f90')

error_fortran = library('error_fortran', 'error_lib.f90')

pointer_fortran = library('pointer_fortran', 'pointer_lib.f90')

struct_fortran = library('struct_fortran', 'struct_lib.f90')

submodule_fortran = library('submodule',
sources: ['module.f90', 'submodule.f90']
)

# -- Fortran calling C++
fortran_cxx_vector = executable('fortran_cxx_vector',
sources: 'vector_main.f90',
link_with: vector_cxx,
dependencies: cstdlib,
link_language: 'fortran'
)
test('Fortran C++ vector', fortran_cxx_vector, timeout: 5)

fortran_cxx_struct = executable('fortran_cxx_struct',
sources: 'struct_main.f90',
include_directories: '../c',
link_with: struct_cxx,
dependencies: cstdlib,
link_language: 'fortran'
)
test('Fortran C++ struct', fortran_cxx_struct,  timeout: 5)

fortran_cxx_err = executable('fortran_cxx_err',
sources: 'error_main.f90',
link_with: error_cxx,
dependencies: cstdlib,
link_language: 'fortran'
)
test('Fortran C++ error', fortran_cxx_err,
timeout: 5,
should_fail: true)

# -- Fortran calling C
fortran_c_vector = executable('fortran_c_vector',
sources: 'vector_main.f90',
link_with: vector_c,
link_language: 'fortran'
)
test('Fortran C vector', fortran_c_vector,  timeout: 5)

fortran_c_struct = executable('fortran_c_struct',
sources: 'struct_main.f90',
link_with: struct_c,
link_language: 'fortran'
)
test('Fortran C struct', fortran_c_struct,  timeout: 5)

fortran_c_err = executable('fortran_c_err',
sources: 'error_main.f90',
link_with: error_c,
link_language: 'fortran'
)
test('Fortran C error', fortran_c_err,
timeout: 5,
should_fail: true)
