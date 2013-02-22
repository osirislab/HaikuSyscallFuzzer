	;; Evan Jensen 022213
BITS 32
global fuzz
section .data
extern printf
	;; void fuzz(unit32_t startCall,unit32_t calltype)
fuzz:
	xor eax,eax
	mov ecx, [esp-8]	;arg2
	cmp ecx,3		;arg testing there are only 3 fuzzing methods
	jbe fuzz.writeStack		;if it's good continue with fuzzing
	ret			;get here if called with second arg >=4

.writeStack:			;Here we write 16 args to the stack
	push esp		;In the future I will fuzz these args
	inc eax			;Here we just see what happens!
	cmp eax, 16
	jz fuzz.fuzzer
	jmp fuzz.writeStack 

.fuzzer:
	mov edx, esp
	mov eax, [esp-4]	;arg1

.fuzz:
	cmp eax,0x100		;Test syscall number
	jae fuzz.end		;exit if too high 
	jmp [fuzzTable+4*ecx-4]	;fuzz based on the fuzzing method
.finishCall:
	inc eax			;Increment syscall#
	jmp fuzz.fuzz		;Try again

	
.end:				;fuzzing done, no crashes :(
	add esp, 16*4
	ret


	;; set up fuzzing stuff
	;; I can't think of a better way to do this
	
sysenter:
	sysenter
	jmp fuzz.finishCall
callgate:
	jmp 0xffff000c
	jmp fuzz.finishCall
int99:
	int 0x99
	jmp fuzz.finishCall

fuzzTable:	dd sysenter,callgate,int99 ;important these match the c fuzzer