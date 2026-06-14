#include <stddef.h>

enum {
	POLY_STATUS_SUCCESS = 0,
	POLY_STATUS_INVALID_TYPE = 1,
	POLY_STATUS_NULL_PTR = 2,
	POLY_STATUS_ZERO_DIMS = 3,
	POLY_STATUS_ALLOC_FAIL = 4,
	POLY_STATUS_BAD_OBJECT_PTR = 5,
	POLY_STATUS_FORTDATA_PTR = 6,
	POLY_STATUS_SET_DATA_DEALLOC_FAIL = 7,
	POLY_STATUS_SET_DATA_ALLOC_FAIL = 8,
	POLY_STATUS_DESTRUCT_DEALLOC_FAIL = 9
};

#ifdef __cplusplus
extern "C" {
#endif

int objconstruct_C(int*, void**, float**, const size_t*, const size_t*);
int objuse_C(int*, void**);
int destruct_C(int*, void**);

#ifdef __cplusplus
}
#endif
