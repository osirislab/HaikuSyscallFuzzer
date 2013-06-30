#ifndef fuzzer
#define fuzzer
#include <stdint.h>

void fuzzint99(unsigned int);
void fuzzsyscall(unsigned int);
void fuzzcallgate(unsigned int);
void fuzz(unsigned int,unsigned int);

#endif
