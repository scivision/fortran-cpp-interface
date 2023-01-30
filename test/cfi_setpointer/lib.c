#include <ISO_Fortran_binding.h>

int arr[3] = { 2, 3, 4 };

void fcpoint(CFI_cdesc_t* f_p) {
  CFI_index_t nbar[1] = {3};
  CFI_CDESC_T(1) c_p;

  CFI_establish((CFI_cdesc_t* )&c_p, arr, CFI_attribute_pointer, CFI_type_int,
                nbar[0]*sizeof(int), 1, nbar);
  CFI_setpointer(f_p, (CFI_cdesc_t *)&c_p, NULL);
}
