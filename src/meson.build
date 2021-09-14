subdir('c')

subdir('cxx')

subdir('fortran')

# -- Fortran calling C++
fortran_call_cxx = executable('fortran_call_cxx',
  sources: files('fortran/main.f90'),
  link_with: math_cxx,
  link_language: 'fortran'
)
test('Fortran call C++', fortran_call_cxx, timeout: 5)

# -- Fortran calling C
fortran_call_c = executable('fortran_call_c',
  sources: files('fortran/main.f90'),
  link_with: math_c,
  link_language: 'fortran'
)
test('Fortran call C', fortran_call_c,  timeout: 5)

# -- C calling Fortran
c_fortran_error = executable('c_fortran_error',
  sources: files('c/error_main.c'),
  link_with: error_fortran,
  link_language: 'fortran'
)
test('C Fortran error', c_fortran_error,
  timeout: 5,
  should_fail: true)

# -- C++ calling Fortran
cxx_call_fortran = executable('cxx_call_fortran',
  sources: files('cxx/main.cxx'),
  link_with: math_fortran
)
test('C++ call Fortran', cxx_call_fortran, timeout: 5)

cxx_fortran_error = executable('cxx_fortran_error',
  sources: files('cxx/error_main.cxx'),
  link_with: error_fortran,
  link_language: 'fortran'
)
test('C++ Fortran error', cxx_fortran_error,
  timeout: 5,
  should_fail: true)
