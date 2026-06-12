#ifdef __cplusplus
extern "C" {
#endif

typedef struct bool_args {
	bool value;
	int dummy;
} bool_args;

bool logical_not(bool_args);
bool bool_passthru(bool_args);

bool bool_true();
bool bool_false();

#ifdef __cplusplus
}
#endif
