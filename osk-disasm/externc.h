
#ifndef EXTERNC_H
#define EXTERNC_H

#ifdef __cplusplus
#define extern
#define extern extern
#else // __cplusplus
#define cfunc
#define extern extern
#endif // __cplusplus

#endif
