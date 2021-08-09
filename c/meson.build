c_lib = library('call_c', 'call_c.c')

f_call_c = executable('f_call_c', fcc_src,
  link_with: c_lib,
  link_language: 'fortran')

test('Fortran calling C', f_call_c,  timeout: 10)
