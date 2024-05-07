// taken from
// https://fortran-lang.discourse.group/t/return-an-array-of-strings-from-fortran-to-c/5100/15
#include <iostream>
#include <cstdio>
#include <cstdlib>

#include <span>
#include <ranges>
#include <algorithm>
#include <vector>
#include <string>
#include <source_location>

#include <ISO_Fortran_binding.h>



static const std::vector<std::string> cfi_errstrs = {
    "No error detected.",
    "The base address member of a C descriptor is a null pointer in a context that requires a non-null pointer value.",
    "The base address member of a C descriptor is not a null pointer in a context that requires a null pointer value.",
    "The value supplied for the element length member of a C descriptor is not valid.",
    "The value supplied for the rank member of a C descriptor is not valid.",
    "The value supplied for the type member of a C descriptor is not valid.",
    "The value supplied for the attribute member of a C descriptor is not valid.",
    "The value supplied for the extent member of a CFI_dim_t structure is not valid.",
    "A C descriptor is invalid in some way.",
    "Memory allocation failed.",
    "A reference is out of bounds.",
    "Unrecognized status code."
};

// Returns the description string for an error code.
//
std::string cfiGetErrorString(int stat) {

    switch (stat) {
        case CFI_SUCCESS:                  return cfi_errstrs[0];
        case CFI_ERROR_BASE_ADDR_NULL:     return cfi_errstrs[1];
        case CFI_ERROR_BASE_ADDR_NOT_NULL: return cfi_errstrs[2];
        case CFI_INVALID_ELEM_LEN:         return cfi_errstrs[3];
        case CFI_INVALID_RANK:             return cfi_errstrs[4];
        case CFI_INVALID_TYPE:             return cfi_errstrs[5];
        case CFI_INVALID_ATTRIBUTE:        return cfi_errstrs[6];
        case CFI_INVALID_EXTENT:           return cfi_errstrs[7];
        case CFI_INVALID_DESCRIPTOR:       return cfi_errstrs[8];
        case CFI_ERROR_MEM_ALLOCATION:     return cfi_errstrs[9];
        case CFI_ERROR_OUT_OF_BOUNDS:      return cfi_errstrs[10];
    }

    return cfi_errstrs[11];
}

void check_cfi(int s)
{
  if (s != CFI_SUCCESS){
    constexpr std::source_location loc = std::source_location::current();
    std::cerr << loc.file_name() << ":" << loc.line() << " CFI API failed with error: (" << s << ") " << cfiGetErrorString(s) << "\n";
  }
}

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
    return final_action( f );
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
extern "C" void draw_random_samples(const int n, CFI_cdesc_t *samples);

// Same procedure as the one below, but implemented in Fortran
extern "C" double f_estimate_pi(const int n);

/* Calculate pi using the Monte-Carlo method.
 *
 * Random numbers are generated in Fortran just for the
 * sake of testing the F2018 enhanced C interoperability.
 */
double estimate_pi(const int n)
{
    CFI_CDESC_T(2) samples_;
    const auto samples = (CFI_cdesc_t *) &samples_;

    check_cfi( CFI_establish(samples,
                             nullptr,
                             CFI_attribute_allocatable,
                             CFI_type_double,
                             0 /* ignored */,
                             static_cast<CFI_rank_t>(2),
                             nullptr /* ignored */) );

    // Make sure we don't forget to deallocate
    auto dealloc = finally([&]{
        if (samples->base_addr) {
            check_cfi( CFI_deallocate(samples) );
        }
    });

    draw_random_samples( n, samples);

    auto inside_of_circle = [=](int i)
    {
        // <!> Pointer arithmetic <!>

        const double x = *( static_cast<double*>(samples->base_addr) + i);
        const double y = *( static_cast<double*>(samples->base_addr) + i + n);

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

    return 4.0 * (static_cast<double>(ncircle)) / n;

} // dealloc called here

int main(int argc, char const *argv[])
{

    const int N = (argc > 1) ? atoi(argv[1]) : 1000;

    std::cout << "pi = " <<   estimate_pi( N ) << '\n';
    std::cout << "pi = " << f_estimate_pi( N ) << '\n';

    return 0;
}
