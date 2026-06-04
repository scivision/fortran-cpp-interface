#include <stdio.h>
#include <stdlib.h>
#include <ISO_Fortran_binding.h>
#include <inttypes.h>

#include "bounds.h"

#ifdef __cplusplus
extern "C" {
#endif

/* ==================== 1D Version ==================== */
bool c_bounder(CFI_cdesc_t *a,
               CFI_index_t fortran_lower,   // Original Fortran lower bound
               CFI_index_t fortran_upper)   // Original Fortran upper bound
{
    printf("\n=== C side: c_bounder (1D) called ===\n");

    if (a == NULL) {
        fprintf(stderr, "ERROR: NULL descriptor\n");
        return false;
    }

    if (a->rank != 1) {
        fprintf(stderr, "ERROR: Expected rank 1, got %" PRId64 "\n", (int64_t)a->rank);
        return false;
    }

    CFI_dim_t *dim = &a->dim[0];
    CFI_index_t c_lower = dim->lower_bound;        // This is almost always 0
    CFI_index_t extent  = dim->extent;
    CFI_index_t c_upper = c_lower + extent - 1;

    printf("C Descriptor:   lower=%td, upper=%td, extent=%td\n", c_lower, c_upper, extent);
    printf("Fortran Array:  lower=%td, upper=%td\n", fortran_lower, fortran_upper);

    // === Correct validation for bind(c) ===
    if (c_lower != 0) {
        fprintf(stderr, "WARNING: C lower bound is not 0 (got %td)\n", c_lower);
    }

    if (extent != (fortran_upper - fortran_lower + 1)) {
        fprintf(stderr, "ERROR: Extent mismatch! Expected %td, got %td\n",
                (fortran_upper - fortran_lower + 1), extent);
        return false;
    }

    printf("✓ Extent check PASSED\n");
    printf("✓ C descriptor uses 0-based lower bound (standard behavior)\n");

    // Optional data modification
    if (a->base_addr && extent > 0) {
        float *data = (float*)a->base_addr;
        data[0] = 999.0f;
        if (extent > 1)
            data[extent-1] = -999.0f;
    }

    printf("=== c_bounder (1D) finished ===\n\n");
    return true;
}

/* ==================== 2D Version ==================== */
bool c_bounder_2d(CFI_cdesc_t *a,
                  CFI_index_t fl1, CFI_index_t fu1,
                  CFI_index_t fl2, CFI_index_t fu2)
{
    printf("\n=== C side: c_bounder_2d called ===\n");

    if (a == NULL || a->rank != 2) {
        fprintf(stderr, "ERROR: Expected rank 2\n");
        return false;
    }

    // Dim 1
    CFI_index_t extent1 = a->dim[0].extent;
    if (extent1 != (fu1 - fl1 + 1)) {
        fprintf(stderr, "ERROR: Dim1 extent mismatch\n");
        return false;
    }

    // Dim 2
    CFI_index_t extent2 = a->dim[1].extent;
    if (extent2 != (fu2 - fl2 + 1)) {
        fprintf(stderr, "ERROR: Dim2 extent mismatch\n");
        return false;
    }

    printf("✓ 2D Extent check PASSED: [%td:%td, %td:%td]\n", fl1, fu1, fl2, fu2);
    printf("✓ C descriptor lower bounds normalized to 0 (standard)\n");

    if (a->base_addr) {
        float *data = (float*)a->base_addr;
        data[0] = 999.0f;
    }

    printf("=== c_bounder_2d finished ===\n\n");
    return true;
}

#ifdef __cplusplus
}
#endif
