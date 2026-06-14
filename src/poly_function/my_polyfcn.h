#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

int objconstruct_C(int*, void**, float**, const size_t*, const size_t*);
int objuse_C(int*, void**);
int destruct_C(int*, void**);

#ifdef __cplusplus
}
#endif
