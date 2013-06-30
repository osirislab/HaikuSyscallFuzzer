#include <stdio.h>
#include <stdlib.h>
#include "fuzzingFunction.h"

#define INT99 1
#define SYSENTER 2
#define CALLGATE 3

int main(int argc,char** argv){

	unsigned int fuzzType;
	unsigned int startingCall;
	
	if(argc<2){
		   printf("usage %s <fuzztype> <syscallStart#>\n"
		"fuzztype:\n1.) int99\n2.) sysenter\n3.)callgate\n",argv[0]);
		   exit(1);
	}


	fuzzType = strtoul(argv[1], 0, 0);

	startingCall = strtoul(argv[2], 0, 0);
	
	if(fuzz(fuzzType,startingCall)==-1)
	  puts("You messed something up");
	
	
	printf("Fuzzing Over\n");
	return 0;
}
