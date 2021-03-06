/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#include <_mingw_mac.h>

	.file	"cosl_internal.S"
	.text
#ifdef _WIN64
	.align 8
#else
	.align 4
#endif
.globl __MINGW_USYMBOL(__cosl_internal)
	.def	__MINGW_USYMBOL(__cosl_internal);	.scl	2;	.type	32;	.endef
__MINGW_USYMBOL(__cosl_internal):
#ifdef _WIN64
	fldt	(%rdx)
	fcos
	fnstsw	%ax
	testl	$0x400,%eax
	jz	1f
	fldpi
	fadd	%st(0)
	fxch	%st(1)
2:	fprem1
	fnstsw	%ax
	testl	$0x400,%eax
	jnz	2b
	fstp	%st(1)
	fcos
1:	movq %rcx,%rax
	movq	$0,8(%rcx)
	fstpt (%rcx)
	ret
#else
	fldt	4(%esp)
	fcos
	fnstsw	%ax
	testl	$0x400,%eax
	jnz	1f
	ret
1:	fldpi
	fadd	%st(0)
	fxch	%st(1)
2:	fprem1
	fnstsw	%ax
	testl	$0x400,%eax
	jnz	2b
	fstp	%st(1)
	fcos
	ret
#endif

