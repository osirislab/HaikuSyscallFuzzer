#include <stdio.h>
#include <stdlib.h>
#include "fuzzingFunction.h"
int main(int argc,char** argv){
	unsigned int startingCall;
	startingCall = strtoul(argv[1], 0, 0);
	fuzz(startingCall);
	return 0;
}
