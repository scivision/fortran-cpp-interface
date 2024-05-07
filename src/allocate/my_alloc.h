#ifdef __cplusplus
extern "C" {
#endif

void alloc1(float**, float**, const size_t*);
void alloc2(float**, float**, const size_t*);
void alloc3(float**, float**, const size_t*);
void alloc4(float**, float**, const size_t*);

void dealloc1(float**, float**, const size_t*);
void dealloc2(float**, float**, const size_t*);
void dealloc3(float**, float**, const size_t*);
void dealloc4(float**, float**, const size_t*);

void falloc1(float**, const size_t*);
void fdealloc1(float**);

#ifdef __cplusplus
}
#endif
