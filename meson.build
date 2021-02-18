project('Fortran_c_cxx_interface', 'c', 'cpp', 'fortran',
version : '1.0.0',
meson_version: '>= 0.52.0',
default_options : ['default_library=static', 'buildtype=release', 'warning_level=3',
'cpp_std=c++11', 'c_std=c99'])

call_f = library('call_f', 'c_call_f.f90')
c_call_f = executable('c_call_f', 'cxx_call_f.cxx', link_with: call_f)
test('C++ calling Fortran', c_call_f, timeout: 10)

c_lib = library('call_c', 'call_c.c')
f_call_c = executable('f_call_c', 'f_call_c.f90',
  link_with: c_lib,
  link_language: 'fortran')
test('Fortran calling C', f_call_c,  timeout: 10)

cxx_lib = library('call_cxx', 'call_cxx.cxx')
f_call_cxx = executable('f_call_cxx', 'f_call_c.f90',
  link_with: cxx_lib,
  link_language: 'fortran')
test('Fortran calling C++', f_call_cxx, timeout: 10)
