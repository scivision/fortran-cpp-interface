#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

void alloc1(float**, float**, const size_t*);
void alloc2(float**, float**, const size_t*);
void alloc3(float**, float**, const size_t*);
void alloc4(float**, float**, const size_t*);

void dealloc1(float**, float**);
void dealloc2(float**, float**);
void dealloc3(float**, float**);
void dealloc4(float**, float**);

void falloc1(float** Ac, const size_t dims[1]);
void fdealloc1(float** Ac);

#ifdef __cplusplus
}
#endif
