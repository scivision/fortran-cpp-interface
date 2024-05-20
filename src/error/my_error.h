#ifdef __cplusplus
extern "C" {
#endif

#if !defined(__has_c_attribute)
#  define __has_c_attribute(x)  0
#endif

#if __has_c_attribute(noreturn)
[[noreturn]]
#elif __has_c_attribute(_Noreturn)
[[_Noreturn]]
#endif
void err_c(int);

#if __has_cpp_attribute(noreturn)
[[noreturn]]
#endif
void err_cpp(int);

void error_fortran(int*);

#ifdef __cplusplus
}
#endif
