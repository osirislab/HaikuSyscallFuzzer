BITS 32
global fuzz
section .data
extern printf

fuzz:
	xor eax,eax
.top:
	push esp
	inc eax
	cmp eax, 16
	jz fuzz.fuzzer
	jmp fuzz.top

.fuzzer:
	mov ecx, 16
	mov edx, esp
	mov eax, [esp-4]
.fuzz
	cmp eax,0x100
	jz fuzz.end
	jmp 0xffff000c
	;int 99
	;sysenter
	inc eax
	jmp fuzz.fuzz

.end
	add esp, 16*4
	ret
