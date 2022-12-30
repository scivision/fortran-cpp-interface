#ifdef __cplusplus
extern "C" {
#endif

extern void alloc1(float**, float**, size_t*);
extern void alloc2(float**, float**, size_t*);
extern void alloc3(float**, float**, size_t*);
extern void alloc4(float**, float**, size_t*);

extern void dealloc1(float**, float**, size_t*);
extern void dealloc2(float**, float**, size_t*);
extern void dealloc3(float**, float**, size_t*);
extern void dealloc4(float**, float**, size_t*);

extern void falloc1(float**, size_t*);
extern void fdealloc1(float**);

#ifdef __cplusplus
}
#endif
