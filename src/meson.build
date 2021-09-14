subdir('c')

subdir('cxx')

subdir('fortran')

# -- Fortran calling C++
fortran_call_cxx = executable('fortran_call_cxx',
  sources: files('fortran/main.f90'),
  link_with: math_cxx,
  link_language: 'fortran')
test('Fortran call C++', fortran_call_cxx, timeout: 5)

# -- Fortran calling C
fortran_call_c = executable('fortran_call_c',
  sources: files('fortran/main.f90'),
  link_with: math_c,
  link_language: 'fortran'
)
test('Fortran call C', fortran_call_c,  timeout: 5)

# -- C++ calling Fortran
cxx_call_fortran = executable('cxx_call_fortran',
  sources: files('cxx/cxx_main.cxx'),
  link_with: math_fortran)
test('C++ calling Fortran', cxx_call_fortran, timeout: 10)
