call_f = library('call_f', 'c_call_f.f90')
c_call_f = executable('c_call_f', 'cxx_call_f.cxx', link_with: call_f)
test('C++ calling Fortran', c_call_f, timeout: 10)

cxx_lib = library('call_cxx', 'call_cxx.cxx')
f_call_cxx = executable('f_call_cxx', fcc_src,
  link_with: cxx_lib,
  link_language: 'fortran')
test('Fortran calling C++', f_call_cxx, timeout: 10)
