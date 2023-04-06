	.file	"matrixMultiplication.c"
	.section	.rodata
	.align 8
.LC3:
	.string	"Matrix multiplication took %.0f milliseconds.\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$12000064, %rsp
	movl	$1000, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	movl	$0, -8(%rbp)
	jmp	.L3
.L4:
	cvtsi2ss	-4(%rbp), %xmm1
	cvtsi2ss	-24(%rbp), %xmm0
	mulss	%xmm0, %xmm1
	cvtsi2ss	-8(%rbp), %xmm0
	addss	%xmm1, %xmm0
	movl	-8(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	imulq	$1000, %rdx, %rdx
	addq	%rdx, %rax
	movss	%xmm0, -4000048(%rbp,%rax,4)
	cvtsi2ss	-8(%rbp), %xmm1
	cvtsi2ss	-24(%rbp), %xmm0
	mulss	%xmm0, %xmm1
	cvtsi2ss	-4(%rbp), %xmm0
	addss	%xmm1, %xmm0
	movl	-8(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	imulq	$1000, %rdx, %rdx
	addq	%rdx, %rax
	movss	%xmm0, -8000048(%rbp,%rax,4)
	addl	$1, -8(%rbp)
.L3:
	movl	-8(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L4
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L5
	call	clock
	movq	%rax, -32(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L6
.L11:
	movl	$0, -16(%rbp)
	jmp	.L7
.L10:
	movl	-16(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	imulq	$1000, %rdx, %rdx
	addq	%rax, %rdx
	movl	.LC0(%rip), %eax
	movl	%eax, -12000048(%rbp,%rdx,4)
	movl	$0, -20(%rbp)
	jmp	.L8
.L9:
	movl	-16(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	imulq	$1000, %rdx, %rdx
	addq	%rdx, %rax
	movss	-12000048(%rbp,%rax,4), %xmm1
	movl	-20(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	imulq	$1000, %rdx, %rdx
	addq	%rdx, %rax
	movss	-4000048(%rbp,%rax,4), %xmm2
	movl	-16(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	imulq	$1000, %rdx, %rdx
	addq	%rdx, %rax
	movss	-8000048(%rbp,%rax,4), %xmm0
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movl	-16(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	imulq	$1000, %rdx, %rdx
	addq	%rdx, %rax
	movss	%xmm0, -12000048(%rbp,%rax,4)
	addl	$1, -20(%rbp)
.L8:
	movl	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L9
	addl	$1, -16(%rbp)
.L7:
	movl	-16(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L10
	addl	$1, -12(%rbp)
.L6:
	movl	-12(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L11
	call	clock
	movq	%rax, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	-40(%rbp), %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	.LC2(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -12000056(%rbp)
	movsd	-12000056(%rbp), %xmm0
	movl	$.LC3, %edi
	movl	$1, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	0
	.align 8
.LC1:
	.long	0
	.long	1093567616
	.align 8
.LC2:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-39)"
	.section	.note.GNU-stack,"",@progbits
