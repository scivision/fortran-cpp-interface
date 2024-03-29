// taken from
// https://fortran-lang.discourse.group/t/return-an-array-of-strings-from-fortran-to-c/5100/15
#include <iostream>
#include <cstdio>
#include <cstdlib>

#include <span>
#include <ranges>
#include <algorithm>

#include <ISO_Fortran_binding.h>

static const char *cfi_errstrs[12] = {
    "No error detected.\n",
    "The base address member of a C descriptor is a null pointer in a context that requires a non-null pointer value.\n",
    "The base address member of a C descriptor is not a null pointer in a context that requires a null pointer value.\n",
    "The value supplied for the element length member of a C descriptor is not valid.\n",
    "The value supplied for the rank member of a C descriptor is not valid.\n",
    "The value supplied for the type member of a C descriptor is not valid.\n",
    "The value supplied for the attribute member of a C descriptor is not valid.\n",
    "The value supplied for the extent member of a CFI_dim_t structure is not valid.\n",
    "A C descriptor is invalid in some way.\n",
    "Memory allocation failed.\n",
    "A reference is out of bounds.\n",
    "Unrecognized status code.\n"
};

// Returns the description string for an error code.
//
const char* cfiGetErrorString(int stat) {

    switch (stat) {
        case CFI_SUCCESS:                  return cfi_errstrs[0]  ; break;
        case CFI_ERROR_BASE_ADDR_NULL:     return cfi_errstrs[1]  ; break;
        case CFI_ERROR_BASE_ADDR_NOT_NULL: return cfi_errstrs[2]  ; break;
        case CFI_INVALID_ELEM_LEN:         return cfi_errstrs[3]  ; break;
        case CFI_INVALID_RANK:             return cfi_errstrs[4]  ; break;
        case CFI_INVALID_TYPE:             return cfi_errstrs[5]  ; break;
        case CFI_INVALID_ATTRIBUTE:        return cfi_errstrs[6]  ; break;
        case CFI_INVALID_EXTENT:           return cfi_errstrs[7]  ; break;
        case CFI_INVALID_DESCRIPTOR:       return cfi_errstrs[8]  ; break;
        case CFI_ERROR_MEM_ALLOCATION:     return cfi_errstrs[9]  ; break;
        case CFI_ERROR_OUT_OF_BOUNDS:      return cfi_errstrs[10] ; break;
    }

    return cfi_errstrs[11];
}

#define CHECK_CFI(func)                                                        \
{                                                                              \
    int stat = (func);                                                         \
    if (stat != CFI_SUCCESS) {                                                 \
        fprintf(stderr,"%s:%d: CFI API failed with error: (%d) %s",            \
            __FILE__, __LINE__, stat, cfiGetErrorString(stat));                \
    }                                                                          \
}                                                                              \

template<typename Action>
class final_action
{
public:
    final_action( Action action )
    : action_( action ) {}

    ~final_action()
    {
        action_();
    }

private:
    Action action_;
};

template< class Fn >
[[nodiscard]] auto finally( Fn const & f )
{
    return final_action(( f ));
}

//
namespace stdv = std::views;
namespace stdr = std::ranges;

// Draws random samples in the unit square [0,1)^2
//
// Arguments:
// [in]        n: the number of samples
// [out] samples: an array of (x,y) values, shape [n,2]
//
extern "C" void draw_random_samples(int n, CFI_cdesc_t *samples);

// Same procedure as the one below, but implemented in Fortran
extern "C" double f_estimate_pi(int n);

/* Calculate pi using the Monte-Carlo method.
 *
 * Random numbers are generated in Fortran just for the
 * sake of testing the F2018 enhanced C interoperability.
 */
double estimate_pi(int n)
{
    CFI_CDESC_T(2) samples_;
    const auto samples = (CFI_cdesc_t *) &samples_;

    CHECK_CFI( CFI_establish(samples,
                             NULL,
                             CFI_attribute_allocatable,
                             CFI_type_double,
                             0 /* ignored */,
                             (CFI_rank_t) 2,
                             NULL /* ignored */) )

    // Make sure we don't forget to deallocate
    auto dealloc = finally([&]{
        if (samples->base_addr) {
            CHECK_CFI( CFI_deallocate(samples) )
        }
    });

    draw_random_samples( n, samples);

    auto inside_of_circle = [=](int i)
    {
        // <!> Pointer arithmetic <!>

        const double x = *( (double *) samples->base_addr + i);
        const double y = *( (double *) samples->base_addr + i + n);

        return x*x + y*y < 1;
    };

#if 0
    //
    // Old-fashioned approach
    //
    int ncircle = 0;
    for (int i = 0; i < n; ++i) {
        if (inside_of_circle(i)) ncircle++;
    }
#else
    //
    // Modern approach with views and ranges
    //
    using std::ranges::count_if;
    using std::views::iota;

    int ncircle = count_if( iota(0,n-1), inside_of_circle );
#endif

    return 4.0 * ((double) ncircle) / n;

} // dealloc called here

int main(int argc, char const *argv[])
{

    int N = 1000;
    if (argc > 1)
      N = atoi(argv[1]);

    std::cout << "pi = " <<   estimate_pi( N ) << '\n';
    std::cout << "pi = " << f_estimate_pi( N ) << '\n';

    return 0;
}
