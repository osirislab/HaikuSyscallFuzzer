BITS 32
global fuzzint99
global fuzzsysenter
global fuzzcallgate
section .data
extern printf

%define COMMPAGE_GATE 0xffff000c

fuzzint99:
	xor eax,eax
.top:
	push esp
	inc eax
	cmp eax, 16
	jz fuzzint99.fuzzer
	jmp fuzzint99.top

.fuzzer:
	mov ecx, 16
	mov edx, esp
	mov eax, [esp-4]
.fuzz
	cmp eax,0x100
	jz fuzzint99.end
	;jmp 0xffff000c
	int 99
	;sysenter
	inc eax
	jmp fuzzint99.fuzz

.end
	add esp, 16*4
	ret


fuzzcallgate:
	xor eax,eax
.top:
	push esp
	inc eax
	cmp eax, 16
	jz fuzzcallgate.fuzzer
	jmp fuzzcallgate.top

.fuzzer:
	mov esp, ecx
	mov eax, [esp-4]
.fuzz
	cmp eax,0x100
	jz fuzzcallgate.end
	call dword [0xffff000c]
	;int 99
	;sysenter
	inc eax
	jmp fuzzcallgate.fuzz

.end
	add esp, 16*4
	ret


fuzzsysenter:
	xor eax,eax
.top:
	push esp
	inc eax
	cmp eax, 16
	jz fuzzsysenter.fuzzer
	jmp fuzzsysenter.top

.fuzzer:
	mov ecx, 16
	mov edx, esp
	mov eax, [esp-4]
.fuzz
	cmp eax,0x100
	jz fuzzsysenter.end
	;jmp 0xffff000c
	;int 99
	sysenter
	inc eax
	jmp fuzzsysenter.fuzz

.end
	add esp, 16*4
	ret
