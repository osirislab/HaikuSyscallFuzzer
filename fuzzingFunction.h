#ifndef fuzzer
#define fuzzer
#include <stdint.h>

#define INT99 1
#define SYSENTER 2
#define CALLGATE 3


void fuzzint99(unsigned int);
void fuzzsyscall(unsigned int);
void fuzzcallgate(unsigned int);
int fuzz(unsigned int,unsigned int);

#endif
