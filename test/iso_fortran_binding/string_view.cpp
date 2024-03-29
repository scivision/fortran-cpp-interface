// https://fortran-lang.discourse.group/t/passing-strings-to-c-functions-without-copying/2842/3

#include <string_view>
#include <iostream>

#include "ISO_Fortran_binding.h"

extern "C" {
   void echo_c( const CFI_cdesc_t* Fstr )
   {
      auto view = std::string_view((char *)Fstr->base_addr).substr(0, Fstr->elem_len);
      std::cout << view << "\n";
   }
}
