all:assemble compile link
assemble:
	yasm -f elf fuzzingFunction.s
compile:
	gcc fuzz.c -c -o fuzz.o -m32

link:
	gcc *.o -o fuzzer -m32

clean:
	rm fuzzingFunction.o
	rm fuzz.o
	rm fuzzer

