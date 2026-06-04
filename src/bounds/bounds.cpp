#include <iostream>
#include <ISO_Fortran_binding.h>

#include "bounds.h"

// ==================== 1D Version ====================
bool c_bounder(CFI_cdesc_t* a,
               CFI_index_t fortran_lower,
               CFI_index_t fortran_upper)
{
    std::cout << "=== C++: c_bounder (1D) called ===\n";

    if (a == nullptr) {
        std::cerr << "ERROR: nullptr descriptor\n";
        return false;
    }

    if (a->rank != 1) {
        std::cerr << "ERROR: Expected rank 1, got " << a->rank << "\n";
        return false;
    }

    const CFI_dim_t& dim = a->dim[0];
    const CFI_index_t c_lower = dim.lower_bound;
    const CFI_index_t extent   = dim.extent;
    const CFI_index_t c_upper  = c_lower + extent - 1;

    std::cout << "C Descriptor:   lower=" << c_lower << ", upper=" << c_upper << ", extent=" << extent << "\n";
    std::cout << "Fortran Array:  lower=" << fortran_lower << ", upper=" << fortran_upper << "\n";

    if (c_lower != 0) {
        std::cerr << "WARNING: C lower bound is not 0 (got " << c_lower << ")\n";
    }

    if (extent != (fortran_upper - fortran_lower + 1)) {
        std::cerr << "ERROR: Extent mismatch! Expected " << (fortran_upper - fortran_lower + 1) << ", got " << extent << "\n";
        return false;
    }

    std::cout << "✓ Extent check PASSED\n";

    return true;
}

// ==================== 2D Version ====================
bool c_bounder_2d(CFI_cdesc_t* a,
                  CFI_index_t fl1, CFI_index_t fu1,
                  CFI_index_t fl2, CFI_index_t fu2)
{
    std::cout << "=== C++: c_bounder_2d called ===\n";

    if (a == nullptr || a->rank != 2) {
        std::cerr << "ERROR: Expected rank 2\n";
        return false;
    }

    // Check dimensions
    const CFI_index_t extent1 = a->dim[0].extent;
    const CFI_index_t extent2 = a->dim[1].extent;

    if (extent1 != (fu1 - fl1 + 1)) {
        std::cerr << "ERROR: Dim1 extent mismatch\n";
        return false;
    }

    if (extent2 != (fu2 - fl2 + 1)) {
        std::cerr << "ERROR: Dim2 extent mismatch\n";
        return false;
    }

    std::cout << "✓ 2D Extent check PASSED: [" << fl1 << ":" << fu1 << ", " << fl2 << ":" << fu2 << "]\n";

    return true;
}
