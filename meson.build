project('Fortran_c_cxx_interface', 'c', 'cpp', 'fortran',
version : '1.1.1',
meson_version: '>= 0.52.0',
default_options : ['default_library=static', 'buildtype=release', 'warning_level=3',
'cpp_std=c++11', 'c_std=c99'])

fcc_src = files('f_call_c.f90')

subdir('c')

subdir('cxx')
