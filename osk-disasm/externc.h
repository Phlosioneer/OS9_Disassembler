
#ifndef EXTERNC_H
#define EXTERNC_H

#ifdef __cplusplus
#define cfunc extern "C"
#define cglobal extern "C"
#else // __cplusplus
#define cfunc
#define cglobal extern
#endif // __cplusplus

#endif
