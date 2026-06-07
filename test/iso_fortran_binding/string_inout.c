#include <string.h>

#include <ISO_Fortran_binding.h>

void process_strings_cfi(const CFI_cdesc_t *in_desc, CFI_cdesc_t *out_desc) {
    // 1. Get exact lengths directly from the Fortran descriptor
    size_t in_len  = in_desc->elem_len;
    size_t out_len = out_desc->elem_len;

    // 2. Direct pointer access to Fortran's memory
    char *in_ptr  = (char*)(in_desc->base_addr);
    char *out_ptr = (char*)(out_desc->base_addr);

    // Note: Fortran strings are NOT null-terminated!
    // You must use bounded memory operations:
    // printf("C received exact characters: %.*s\n", (int)in_len, in_ptr);

    // Write safely back to Fortran's allocated memory space
    memset(out_ptr, ' ', out_len); // Clear with Fortran space-padding
    strncpy(out_ptr, "Success", out_len < 7 ? out_len : 7);
}
