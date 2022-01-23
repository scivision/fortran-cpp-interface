string_array_fortran = library('string_array_fortran', 'string_array_lib.f90')


c_fortran_string_array = executable('c_fortran_string_array',
  sources: files('c/string_array_main.c'),
  link_with: string_array_fortran,
  link_language: 'fortran'
)
test('C Fortran string array', c_fortran_string_array, timeout: 5)
