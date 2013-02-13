all:assemble compile link
assemble:
	yasm -f elf fuzzingFunction.s
compile:
	gcc fuzz.c -c -o fuzz.o
link:
	gcc *.o -o fuzzer

clean:
	rm fuzzingFunction.o
	rm fuzz.o
	rm fuzzer

