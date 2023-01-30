// https://stackoverflow.com/a/37837472
#include <ISO_Fortran_binding.h>

void alloc3d(CFI_cdesc_t* x) {
  if (x->base_addr) CFI_deallocate(x);

  CFI_index_t lower[3]={-1, 5, 1};
  CFI_index_t upper[3]={20, 9, 5};

  CFI_allocate(x, lower, upper, 0);
}

void dealloc3d(CFI_cdesc_t* x) {
  CFI_deallocate(x);
}
