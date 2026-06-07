#include <algorithm> // for std::min
#include <string>

#include <ISO_Fortran_binding.h>

extern "C" {
    void process_strings_cfi(const CFI_cdesc_t *, CFI_cdesc_t *);
}


void process_strings_cfi(const CFI_cdesc_t *in_desc, CFI_cdesc_t *out_desc) {
    const std::string::size_type in_len = in_desc->elem_len;
    const std::string::size_type out_len = out_desc->elem_len;

    const char *in_ptr = static_cast<const char *>(in_desc->base_addr);
    char *out_ptr = static_cast<char *>(out_desc->base_addr);

    // Fortran character data is fixed-width and not null-terminated.
    const std::string in_value(in_ptr, in_len);
    (void)in_value;
    const std::string out_value("Success");

    // Copy into Fortran buffer using space-padding semantics.
    std::string fortran_out(out_len, ' ');
    fortran_out.replace(0, std::min(out_len, out_value.size()), out_value, 0, std::min(out_len, out_value.size()));
    fortran_out.copy(out_ptr, out_len);
}
