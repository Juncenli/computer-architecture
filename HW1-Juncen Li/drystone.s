	.file	"drystone.c"
	.intel_syntax noprefix
	.text
.globl main
	.type	main, @function
main:
	push	ebp
	mov	ebp, esp
	and	esp, -16
	sub	esp, 16
	call	Proc0
	mov	DWORD PTR [esp], 0
	call	exit
	.size	main, .-main
	.comm	IntGlob,4,4
	.comm	BoolGlob,4,4
	.comm	Char1Glob,1,1
	.comm	Char2Glob,1,1
	.comm	Array1Glob,204,32
	.comm	Array2Glob,10404,32
	.comm	PtrGlb,4,4
	.comm	PtrGlbNext,4,4
	.section	.rodata
	.align 4
.LC0:
	.string	"DHRYSTONE PROGRAM, SOME STRING"
	.align 4
.LC1:
	.string	"DHRYSTONE PROGRAM, 2'ND STRING"
	.align 4
.LC2:
	.string	"Dhrystone time for %ld passes = %ld\n"
	.align 4
.LC3:
	.string	"This machine benchmarks at %ld dhrystones/second\n"
	.text
.globl Proc0
	.type	Proc0, @function
Proc0:
	push	ebp
	mov	ebp, esp
	push	ebx
	sub	esp, 132
	mov	DWORD PTR [esp], 0
	call	time
	mov	DWORD PTR [ebp-20], eax
	mov	ebx, 0
	jmp	.L4
.L5:
	add	ebx, 1
.L4:
	cmp	ebx, 49999999
	jbe	.L5
	mov	DWORD PTR [esp], 0
	call	time
	sub	eax, DWORD PTR [ebp-20]
	mov	DWORD PTR [ebp-12], eax
	mov	DWORD PTR [esp], 48
	call	malloc
	mov	DWORD PTR PtrGlbNext, eax
	mov	DWORD PTR [esp], 48
	call	malloc
	mov	DWORD PTR PtrGlb, eax
	mov	eax, DWORD PTR PtrGlb
	mov	edx, DWORD PTR PtrGlbNext
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR PtrGlb
	mov	DWORD PTR [eax+4], 0
	mov	eax, DWORD PTR PtrGlb
	mov	DWORD PTR [eax+8], 2
	mov	eax, DWORD PTR PtrGlb
	mov	DWORD PTR [eax+12], 40
	mov	eax, OFFSET FLAT:.LC0
	mov	edx, DWORD PTR PtrGlb
	add	edx, 16
	mov	DWORD PTR [esp+8], 31
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], edx
	call	memcpy
	mov	DWORD PTR [esp], 0
	call	time
	mov	DWORD PTR [ebp-20], eax
	mov	ebx, 0
	jmp	.L6
.L12:
	call	Proc5
	call	Proc4
	mov	DWORD PTR [ebp-32], 2
	mov	DWORD PTR [ebp-28], 3
	mov	eax, OFFSET FLAT:.LC1
	mov	DWORD PTR [esp+8], 31
	mov	DWORD PTR [esp+4], eax
	lea	eax, [ebp-102]
	mov	DWORD PTR [esp], eax
	call	memcpy
	mov	DWORD PTR [ebp-40], 1
	lea	eax, [ebp-102]
	mov	DWORD PTR [esp+4], eax
	lea	eax, [ebp-71]
	mov	DWORD PTR [esp], eax
	call	Func2
	test	eax, eax
	sete	al
	movzx	eax, al
	mov	DWORD PTR BoolGlob, eax
	jmp	.L7
.L8:
	mov	edx, DWORD PTR [ebp-32]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	sub	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [ebp-36], eax
	mov	eax, DWORD PTR [ebp-32]
	lea	edx, [ebp-36]
	mov	DWORD PTR [esp+8], edx
	mov	edx, DWORD PTR [ebp-28]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	Proc7
	mov	eax, DWORD PTR [ebp-32]
	add	eax, 1
	mov	DWORD PTR [ebp-32], eax
.L7:
	mov	eax, DWORD PTR [ebp-32]
	cmp	eax, DWORD PTR [ebp-28]
	jl	.L8
	mov	edx, DWORD PTR [ebp-36]
	mov	eax, DWORD PTR [ebp-32]
	mov	DWORD PTR [esp+12], edx
	mov	DWORD PTR [esp+8], eax
	mov	DWORD PTR [esp+4], OFFSET FLAT:Array2Glob
	mov	DWORD PTR [esp], OFFSET FLAT:Array1Glob
	call	Proc8
	mov	eax, DWORD PTR PtrGlb
	mov	DWORD PTR [esp], eax
	call	Proc1
	mov	BYTE PTR [ebp-21], 65
	jmp	.L9
.L11:
	movsx	eax, BYTE PTR [ebp-21]
	mov	DWORD PTR [esp+4], 67
	mov	DWORD PTR [esp], eax
	call	Func1
	mov	edx, DWORD PTR [ebp-40]
	cmp	eax, edx
	jne	.L10
	lea	eax, [ebp-40]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], 0
	call	Proc6
.L10:
	add	BYTE PTR [ebp-21], 1
.L9:
	movzx	eax, BYTE PTR Char2Glob
	cmp	BYTE PTR [ebp-21], al
	jle	.L11
	mov	eax, DWORD PTR [ebp-32]
	imul	eax, DWORD PTR [ebp-28]
	mov	DWORD PTR [ebp-36], eax
	mov	eax, DWORD PTR [ebp-36]
	mov	edx, DWORD PTR [ebp-32]
	mov	DWORD PTR [ebp-108], edx
	mov	edx, eax
	sar	edx, 31
	idiv	DWORD PTR [ebp-108]
	mov	DWORD PTR [ebp-28], eax
	mov	eax, DWORD PTR [ebp-36]
	mov	edx, eax
	sub	edx, DWORD PTR [ebp-28]
	mov	eax, edx
	sal	eax, 3
	mov	ecx, eax
	sub	ecx, edx
	mov	edx, ecx
	mov	eax, DWORD PTR [ebp-32]
	mov	ecx, edx
	sub	ecx, eax
	mov	eax, ecx
	mov	DWORD PTR [ebp-28], eax
	lea	eax, [ebp-32]
	mov	DWORD PTR [esp], eax
	call	Proc2
	add	ebx, 1
.L6:
	cmp	ebx, 49999999
	jbe	.L12
	mov	DWORD PTR [esp], 0
	call	time
	sub	eax, DWORD PTR [ebp-20]
	sub	eax, DWORD PTR [ebp-12]
	mov	DWORD PTR [ebp-16], eax
	mov	eax, OFFSET FLAT:.LC2
	mov	edx, DWORD PTR [ebp-16]
	mov	DWORD PTR [esp+8], edx
	mov	DWORD PTR [esp+4], 50000000
	mov	DWORD PTR [esp], eax
	call	printf
	mov	eax, 50000000
	mov	edx, eax
	sar	edx, 31
	idiv	DWORD PTR [ebp-16]
	mov	edx, eax
	mov	eax, OFFSET FLAT:.LC3
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	printf
	mov	eax, 0
	add	esp, 132
	pop	ebx
	pop	ebp
	ret
	.size	Proc0, .-Proc0
.globl Proc1
	.type	Proc1, @function
Proc1:
	push	ebp
	mov	ebp, esp
	sub	esp, 24
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR PtrGlb
	mov	ecx, DWORD PTR [edx]
	mov	DWORD PTR [eax], ecx
	mov	ecx, DWORD PTR [edx+4]
	mov	DWORD PTR [eax+4], ecx
	mov	ecx, DWORD PTR [edx+8]
	mov	DWORD PTR [eax+8], ecx
	mov	ecx, DWORD PTR [edx+12]
	mov	DWORD PTR [eax+12], ecx
	mov	ecx, DWORD PTR [edx+16]
	mov	DWORD PTR [eax+16], ecx
	mov	ecx, DWORD PTR [edx+20]
	mov	DWORD PTR [eax+20], ecx
	mov	ecx, DWORD PTR [edx+24]
	mov	DWORD PTR [eax+24], ecx
	mov	ecx, DWORD PTR [edx+28]
	mov	DWORD PTR [eax+28], ecx
	mov	ecx, DWORD PTR [edx+32]
	mov	DWORD PTR [eax+32], ecx
	mov	ecx, DWORD PTR [edx+36]
	mov	DWORD PTR [eax+36], ecx
	mov	ecx, DWORD PTR [edx+40]
	mov	DWORD PTR [eax+40], ecx
	mov	edx, DWORD PTR [edx+44]
	mov	DWORD PTR [eax+44], edx
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax+12], 5
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [edx+12]
	mov	DWORD PTR [eax+12], edx
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [edx]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp], eax
	call	Proc3
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	eax, DWORD PTR [eax+4]
	test	eax, eax
	jne	.L15
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [eax+12], 6
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	lea	edx, [eax+8]
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax+8]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	Proc6
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR PtrGlb
	mov	edx, DWORD PTR [edx]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	lea	edx, [eax+12]
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	eax, DWORD PTR [eax+12]
	mov	DWORD PTR [esp+8], edx
	mov	DWORD PTR [esp+4], 10
	mov	DWORD PTR [esp], eax
	call	Proc7
	jmp	.L16
.L15:
	mov	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp+8]
	mov	ecx, DWORD PTR [edx]
	mov	DWORD PTR [eax], ecx
	mov	ecx, DWORD PTR [edx+4]
	mov	DWORD PTR [eax+4], ecx
	mov	ecx, DWORD PTR [edx+8]
	mov	DWORD PTR [eax+8], ecx
	mov	ecx, DWORD PTR [edx+12]
	mov	DWORD PTR [eax+12], ecx
	mov	ecx, DWORD PTR [edx+16]
	mov	DWORD PTR [eax+16], ecx
	mov	ecx, DWORD PTR [edx+20]
	mov	DWORD PTR [eax+20], ecx
	mov	ecx, DWORD PTR [edx+24]
	mov	DWORD PTR [eax+24], ecx
	mov	ecx, DWORD PTR [edx+28]
	mov	DWORD PTR [eax+28], ecx
	mov	ecx, DWORD PTR [edx+32]
	mov	DWORD PTR [eax+32], ecx
	mov	ecx, DWORD PTR [edx+36]
	mov	DWORD PTR [eax+36], ecx
	mov	ecx, DWORD PTR [edx+40]
	mov	DWORD PTR [eax+40], ecx
	mov	edx, DWORD PTR [edx+44]
	mov	DWORD PTR [eax+44], edx
.L16:
	mov	eax, 0
	leave
	ret
	.size	Proc1, .-Proc1
.globl Proc2
	.type	Proc2, @function
Proc2:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	add	eax, 10
	mov	DWORD PTR [ebp-8], eax
	jmp	.L22
.L24:
	nop
.L22:
	movzx	eax, BYTE PTR Char1Glob
	cmp	al, 65
	jne	.L19
	sub	DWORD PTR [ebp-8], 1
	mov	eax, DWORD PTR IntGlob
	mov	edx, DWORD PTR [ebp-8]
	sub	edx, eax
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax], edx
	mov	DWORD PTR [ebp-4], 0
.L19:
	cmp	DWORD PTR [ebp-4], 0
	jne	.L24
	nop
	mov	eax, 0
	leave
	ret
	.size	Proc2, .-Proc2
.globl Proc3
	.type	Proc3, @function
Proc3:
	push	ebp
	mov	ebp, esp
	sub	esp, 24
	mov	eax, DWORD PTR PtrGlb
	test	eax, eax
	je	.L26
	mov	eax, DWORD PTR PtrGlb
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax], edx
	jmp	.L27
.L26:
	mov	DWORD PTR IntGlob, 100
.L27:
	mov	eax, DWORD PTR PtrGlb
	lea	edx, [eax+12]
	mov	eax, DWORD PTR IntGlob
	mov	DWORD PTR [esp+8], edx
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], 10
	call	Proc7
	mov	eax, 0
	leave
	ret
	.size	Proc3, .-Proc3
.globl Proc4
	.type	Proc4, @function
Proc4:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	movzx	eax, BYTE PTR Char1Glob
	cmp	al, 65
	sete	al
	movzx	eax, al
	mov	DWORD PTR [ebp-4], eax
	mov	eax, DWORD PTR BoolGlob
	or	DWORD PTR [ebp-4], eax
	mov	BYTE PTR Char2Glob, 66
	mov	eax, 0
	leave
	ret
	.size	Proc4, .-Proc4
.globl Proc5
	.type	Proc5, @function
Proc5:
	push	ebp
	mov	ebp, esp
	mov	BYTE PTR Char1Glob, 65
	mov	DWORD PTR BoolGlob, 0
	mov	eax, 0
	pop	ebp
	ret
	.size	Proc5, .-Proc5
.globl Proc6
	.type	Proc6, @function
Proc6:
	push	ebp
	mov	ebp, esp
	sub	esp, 24
	mov	eax, DWORD PTR [ebp+12]
	mov	edx, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp], eax
	call	Func3
	test	eax, eax
	jne	.L34
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [eax], 3
.L34:
	cmp	DWORD PTR [ebp+8], 4
	ja	.L35
	mov	eax, DWORD PTR [ebp+8]
	sal	eax, 2
	mov	eax, DWORD PTR .L41[eax]
	jmp	eax
	.section	.rodata
	.align 4
	.align 4
.L41:
	.long	.L36
	.long	.L37
	.long	.L38
	.long	.L45
	.long	.L40
	.text
.L36:
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [eax], 0
	jmp	.L35
.L37:
	mov	eax, DWORD PTR IntGlob
	cmp	eax, 100
	jle	.L42
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [eax], 0
	jmp	.L35
.L42:
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [eax], 3
	jmp	.L35
.L38:
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [eax], 1
	jmp	.L35
.L40:
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [eax], 2
	jmp	.L35
.L45:
	nop
.L35:
	mov	eax, 0
	leave
	ret
	.size	Proc6, .-Proc6
.globl Proc7
	.type	Proc7, @function
Proc7:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	mov	eax, DWORD PTR [ebp+8]
	add	eax, 2
	mov	DWORD PTR [ebp-4], eax
	mov	eax, DWORD PTR [ebp-4]
	mov	edx, DWORD PTR [ebp+12]
	add	edx, eax
	mov	eax, DWORD PTR [ebp+16]
	mov	DWORD PTR [eax], edx
	mov	eax, 0
	leave
	ret
	.size	Proc7, .-Proc7
.globl Proc8
	.type	Proc8, @function
Proc8:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	mov	eax, DWORD PTR [ebp+16]
	add	eax, 5
	mov	DWORD PTR [ebp-8], eax
	mov	eax, DWORD PTR [ebp-8]
	sal	eax, 2
	add	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [ebp+20]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp-8]
	add	eax, 1
	sal	eax, 2
	add	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [ebp-8]
	sal	edx, 2
	add	edx, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [edx]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp-8]
	add	eax, 30
	sal	eax, 2
	add	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [ebp-8]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp-8]
	mov	DWORD PTR [ebp-4], eax
	jmp	.L49
.L50:
	mov	eax, DWORD PTR [ebp-8]
	imul	eax, eax, 204
	add	eax, DWORD PTR [ebp+12]
	mov	edx, DWORD PTR [ebp-4]
	mov	ecx, DWORD PTR [ebp-8]
	mov	DWORD PTR [eax+edx*4], ecx
	add	DWORD PTR [ebp-4], 1
.L49:
	mov	eax, DWORD PTR [ebp-8]
	add	eax, 1
	cmp	eax, DWORD PTR [ebp-4]
	jge	.L50
	mov	eax, DWORD PTR [ebp-8]
	imul	eax, eax, 204
	add	eax, DWORD PTR [ebp+12]
	mov	edx, DWORD PTR [ebp-8]
	sub	edx, 1
	mov	ecx, DWORD PTR [eax+edx*4]
	add	ecx, 1
	mov	DWORD PTR [eax+edx*4], ecx
	mov	eax, DWORD PTR [ebp-8]
	imul	eax, eax, 204
	add	eax, 4080
	add	eax, DWORD PTR [ebp+12]
	mov	edx, DWORD PTR [ebp-8]
	mov	ecx, DWORD PTR [ebp-8]
	sal	ecx, 2
	add	ecx, DWORD PTR [ebp+8]
	mov	ecx, DWORD PTR [ecx]
	mov	DWORD PTR [eax+edx*4], ecx
	mov	DWORD PTR IntGlob, 5
	mov	eax, 0
	leave
	ret
	.size	Proc8, .-Proc8
.globl Func1
	.type	Func1, @function
Func1:
	push	ebp
	mov	ebp, esp
	sub	esp, 24
	mov	edx, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp+12]
	mov	BYTE PTR [ebp-20], dl
	mov	BYTE PTR [ebp-24], al
	movzx	eax, BYTE PTR [ebp-20]
	mov	BYTE PTR [ebp-2], al
	movzx	eax, BYTE PTR [ebp-2]
	mov	BYTE PTR [ebp-1], al
	movzx	eax, BYTE PTR [ebp-1]
	cmp	al, BYTE PTR [ebp-24]
	je	.L53
	mov	eax, 0
	jmp	.L54
.L53:
	mov	eax, 1
.L54:
	leave
	ret
	.size	Func1, .-Func1
.globl Func2
	.type	Func2, @function
Func2:
	push	ebp
	mov	ebp, esp
	sub	esp, 40
	mov	DWORD PTR [ebp-16], 1
	jmp	.L57
.L58:
	mov	eax, DWORD PTR [ebp-16]
	add	eax, 1
	add	eax, DWORD PTR [ebp+12]
	movzx	eax, BYTE PTR [eax]
	movsx	edx, al
	mov	eax, DWORD PTR [ebp-16]
	add	eax, DWORD PTR [ebp+8]
	movzx	eax, BYTE PTR [eax]
	movsx	eax, al
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	Func1
	test	eax, eax
	jne	.L57
	mov	BYTE PTR [ebp-9], 65
	add	DWORD PTR [ebp-16], 1
.L57:
	cmp	DWORD PTR [ebp-16], 1
	jle	.L58
	cmp	BYTE PTR [ebp-9], 86
	jle	.L59
	cmp	BYTE PTR [ebp-9], 90
	jg	.L59
	mov	DWORD PTR [ebp-16], 7
.L59:
	cmp	BYTE PTR [ebp-9], 88
	jne	.L60
	mov	eax, 1
	jmp	.L61
.L60:
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [esp+4], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp], eax
	call	strcmp
	test	eax, eax
	jle	.L62
	add	DWORD PTR [ebp-16], 7
	mov	eax, 1
	jmp	.L61
.L62:
	mov	eax, 0
.L61:
	leave
	ret
	.size	Func2, .-Func2
.globl Func3
	.type	Func3, @function
Func3:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [ebp-4], eax
	cmp	DWORD PTR [ebp-4], 2
	jne	.L65
	mov	eax, 1
	jmp	.L66
.L65:
	mov	eax, 0
.L66:
	leave
	ret
	.size	Func3, .-Func3
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-16)"
	.section	.note.GNU-stack,"",@progbits
