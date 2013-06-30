	;; Evan Jensen 022213
BITS 32
global fuzz
section .data
extern printf
	;; void fuzz(unit32_t startCall,unit32_t calltype)
fuzz:
	push ebp
	mov ebp,esp
	xor eax,eax
	mov ecx, [ebp-0xC]	;arg2
	cmp ecx,3		;arg testing there are only 3 fuzzing methods
	jbe fuzz.writeStack		;if it's good continue with fuzzing
	mov eax,-1
	leave
	ret			;get here if called with second arg >=4

.writeStack:			;Here we write 16 args to the stack
	push esp		;In the future I will fuzz these args
	inc eax			;Here we just see what happens!
	cmp eax, 16
	jnl fuzz.fuzzer
	jmp fuzz.writeStack 

.fuzzer:

	mov eax, [ebp-0x8]	;arg1

.fuzz:
	mov eax, [ebp-0x8]	;arg1
	cmp eax,0x100		;Test syscall number
	jae fuzz.end		;exit if too high 
	jmp [fuzzTable+4*ecx-4]	;fuzz based on the fuzzing method
.finishCall:
	inc dword [ebp-0x8]			;Increment syscall#
	jmp fuzz.fuzz		;Try again

	
.end:				;fuzzing done, no crashes :(
	add esp, 16*4
	leave
	ret


	;; set up fuzzing stuff
	;; I can't think of a better way to do this
	
sysent:
	sysenter
	jmp fuzz.finishCall
callgate:
	call [0xffff000c] 	;pointer to kernelgate
	jmp fuzz.finishCall
int99:
	int 99
	jmp fuzz.finishCall

fuzzTable:	dd sysent,callgate,int99 ;important these match the c fuzzer
