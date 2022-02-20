project('Fortran_c_cxx_interface', 'c', 'cpp', 'fortran',
version : '1.3.0',
meson_version: '>= 0.55.0',
default_options : ['cpp_std=c++11'])

cpp = meson.get_compiler('cpp')
cstdlib = cpp.find_library('stdc++', required : true)

subdir('src')
