// taken from
// https://fortran-lang.discourse.group/t/return-an-array-of-strings-from-fortran-to-c/5100/3
#include <vector>
#include <string_view>
#include <iostream>
#include <cstdlib>

#include "ISO_Fortran_binding.h"

extern "C" {
   // Prototype for the Fortran procedures
   void Finit(void);
   void get_names( CFI_cdesc_t * );
}

int main()
{

   std::vector<std::string_view> vs;

   Finit();

   // Use macro from ISO_Fortran_binding to set aside an address to "description" of string data
   CFI_CDESC_T(1) names;

  CFI_establish((CFI_cdesc_t *)&names, nullptr,
                    CFI_attribute_pointer,
                    CFI_type_char, 0, (CFI_rank_t)1, nullptr);

   // Call the Fortran procedure for string manipulation
   get_names((CFI_cdesc_t *)&names);

   for (int i = 0; i < names.dim[0].extent; i++) {
       vs.push_back(std::string_view((char *)names.base_addr).substr(i * names.elem_len, names.elem_len));
   }
   for (int i = 0; i < names.dim[0].extent; i++) {
       std::cout << vs[i] << "\n";
   }

   return EXIT_SUCCESS;
}
