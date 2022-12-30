#ifdef __cplusplus
extern "C" {
#endif

enum { LMAX = 1000 };

struct params {
  // order and lengths must match in Fortran and C
  int my_int;
  bool my_bool;
  char my_char[LMAX];
};

void struct_check_f(struct params *);
void struct_check_c(struct params *);
void struct_check_cpp(struct params *);

#ifdef __cplusplus
}
#endif
