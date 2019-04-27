.globl main
.data
L79:
.word 27
.ascii "Array index out of bounds.
"
L75:
.word 26
.ascii "Cannot access nil record.
"
L72:
.word 27
.ascii "Array index out of bounds.
"
L68:
.word 26
.ascii "Cannot access nil record.
"
L65:
.word 27
.ascii "Array index out of bounds.
"
L61:
.word 26
.ascii "Cannot access nil record.
"
L58:
.word 27
.ascii "Array index out of bounds.
"
L54:
.word 26
.ascii "Cannot access nil record.
"
L51:
.word 3
.ascii "sdf"
L50:
.word 26
.ascii "Cannot access nil record.
"
L47:
.word 3
.ascii "sfd"
L46:
.word 27
.ascii "Array index out of bounds.
"
L42:
.word 26
.ascii "Cannot access nil record.
"
L39:
.word 27
.ascii "Array index out of bounds.
"
L35:
.word 26
.ascii "Cannot access nil record.
"
L32:
.word 27
.ascii "Array index out of bounds.
"
L28:
.word 4
.ascii "kati"
L27:
.word 26
.ascii "Cannot access nil record.
"
L24:
.word 27
.ascii "Array index out of bounds.
"
L20:
.word 26
.ascii "Cannot access nil record.
"
L17:
.word 27
.ascii "Array index out of bounds.
"
L13:
.word 27
.ascii "Array index out of bounds.
"
L9:
.word 27
.ascii "Array index out of bounds.
"
L5:
.word 5
.ascii "Allos"
L4:
.word 5
.ascii "Kapou"
L3:
.word 7
.ascii "Kapoios"
L2:
.word 0
.ascii ""
L1:
.word 9
.ascii "somewhere"
L0:
.word 5
.ascii "aname"
.text
tig_main:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -48
L81:
move $a0, $a0
sw $ra, -44($fp)
sw $s0, -40($fp)
sw $s1, -36($fp)
sw $s2, -32($fp)
sw $s3, -28($fp)
sw $s4, -24($fp)
sw $s5, -20($fp)
sw $s6, -16($fp)
sw $s7, -12($fp)
li $a0, 10
move $a0, $a0
li $a1, 0
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
move $fp, $a0
li $a1, 5
li $a0, 16
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $a2, $a0
li $a0, 0
sw $a0, 0($a2)
li $a0, 0
sw $a0, 4($a2)
la $a0, L1
sw $a0, 8($a2)
la $a0, L0
sw $a0, 12($a2)
move $a0, $a1
move $a1, $a2
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
move $s0, $a0
li $a0, 100
move $a0, $a0
la $a1, L2
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
move $a1, $a0
li $a0, 16
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $a0, $a0
li $a1, 44
sw $a1, 0($a0)
li $a1, 2432
sw $a1, 4($a0)
la $a1, L4
sw $a1, 8($a0)
la $a1, L3
sw $a1, 12($a0)
move $a1, $a0
li $a0, 8
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $a2, $a0
addi $a0, $a2, 0
move $a3, $a0
li $a0, 3
move $a0, $a0
li $a1, 70
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
sw $a0, 0($a3)
la $a0, L5
sw $a0, 4($a2)
move $a1, $a2
lw $a0, -4($fp)
bgez $a0, L6
L7:
la $a0, L9
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L8:
li $a1, 1
li $a0, 0
add $a0, $fp, $a0
sw $a1, 0($a0)
li $a1, 9
lw $a0, -4($fp)
blt $a1, $a0, L10
L11:
la $a0, L13
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L12:
li $a1, 3
li $a0, 36
add $a0, $fp, $a0
sw $a1, 0($a0)
li $a1, 3
lw $a0, -4($s0)
blt $a1, $a0, L14
L15:
la $a0, L17
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L16:
li $a0, 12
add $a0, $s0, $a0
lw $a0, 0($a0)
bnez $a0, L18
L19:
la $a0, L20
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L18:
li $a1, 3
lw $a0, -4($s0)
blt $a1, $a0, L15
L14:
li $a0, 3
bgez $a0, L16
L82:
j L15
L6:
li $a0, 0
bgez $a0, L8
L83:
j L7
L10:
li $a0, 9
bgez $a0, L12
L84:
j L11
L21:
li $a0, 3
bgez $a0, L23
L22:
la $a0, L24
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L23:
li $a0, 12
add $a0, $s0, $a0
lw $a0, 0($a0)
bnez $a0, L25
L26:
la $a0, L27
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L25:
li $a1, 3
lw $a0, -4($s0)
blt $a1, $a0, L21
L85:
j L22
L29:
li $a0, 3
bgez $a0, L31
L30:
la $a0, L32
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L31:
li $a0, 12
add $a0, $s0, $a0
lw $a0, 0($a0)
bnez $a0, L33
L34:
la $a0, L35
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L33:
li $a1, 3
lw $a0, -4($s0)
blt $a1, $a0, L29
L86:
j L30
L36:
li $a0, 1
bgez $a0, L38
L37:
la $a0, L39
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L38:
li $a0, 4
add $a0, $s0, $a0
lw $a0, 0($a0)
bnez $a0, L40
L41:
la $a0, L42
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L40:
li $a1, 1
lw $a0, -4($s0)
blt $a1, $a0, L36
L87:
j L37
L43:
li $a0, 34
bgez $a0, L45
L44:
la $a0, L46
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L45:
la $a2, L47
li $a0, 136
add $a0, $a1, $a0
sw $a2, 0($a0)
bnez $a1, L48
L49:
la $a0, L50
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L48:
la $a2, L51
li $a0, 12
add $a0, $a1, $a0
sw $a2, 0($a0)
bnez $a1, L52
L53:
la $a0, L54
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L52:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
lw $a0, -4($a0)
bgez $a0, L55
L56:
la $a0, L58
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L57:
bnez $a1, L52
L88:
j L53
L55:
li $a0, 0
bgez $a0, L57
L89:
j L56
L60:
la $a0, L61
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L59:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
lw $a0, -4($a0)
bgez $a0, L62
L63:
la $a0, L65
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L64:
bnez $a1, L59
L90:
j L60
L62:
li $a0, 0
bgez $a0, L64
L91:
j L63
L67:
la $a0, L68
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L66:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
lw $a0, -4($a0)
bgez $a0, L69
L70:
la $a0, L72
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L71:
bnez $a1, L66
L92:
j L67
L69:
li $a0, 0
bgez $a0, L71
L93:
j L70
L74:
la $a0, L75
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L73:
li $a2, 2
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
lw $a0, -4($a0)
blt $a2, $a0, L76
L77:
la $a0, L79
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L78:
bnez $a1, L73
L94:
j L74
L76:
li $a0, 2
bgez $a0, L78
L95:
j L77
L80:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
# system calls for Tiger, when running on SPIM
#
# $Id: sysspim.s,v 1.1 2002/08/25 05:06:41 shivers Exp $

	.globl malloc
	.ent malloc
	.text
malloc:
	# round up the requested amount to a multiple of 4
	add $a0, $a0, 3
	srl $a0, $a0, 2
	sll $a0, $a0, 2

	# allocate the memory with sbrk()
	li $v0, 9
	syscall
	
	j $ra

	.end malloc

	

	.data
	.align 4
getchar_buf:	.byte 0, 0

	.text
getchar:
	# read the character
	la $a0, getchar_buf
	li $a1, 2
	li $v0, 8
	syscall

	# return it
	lb $v0, ($a0)
	j $ra
	

	.data
	.align 4
putchar_buf:	.byte 0, 0

	.text
putchar:
	# save the character so that it is NUL-terminated 
	la $t0, putchar_buf
	sb $a0, ($t0)

	# print it out
	la $a0, putchar_buf
	li $v0, 4
	syscall

	j $ra


	.text	
# just prints the format string, not the arguments
printf:
	li $v0, 4
	syscall
	j $ra


	.text
exit:
	li $v0, 10
	syscall
	

	#.file	1 "runtime.c"
	.option pic2
	.text
	.align 4
	.globl	tig_initArray
	.ent	tig_initArray
tig_initArray:
.LFB1:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI0:
	sd	$ra,48($sp)
.LCFI1:
	sd	$fp,40($sp)
.LCFI2:
.LCFI3:
	move	$fp,$sp
.LCFI4:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	move	$v1,$v0
	sll	$v0,$v1,2
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,16($fp)
	sw	$v1,0($v0)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
.L3:
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	lw	$v1,24($fp)
	slt	$v0,$v1,$v0
	bne	$v0,$zero,.L6
	b	.L4
.L6:
	lw	$v0,24($fp)
	move	$v1,$v0
	sll	$v0,$v1,2
	lw	$v1,28($fp)
	addu	$v0,$v0,$v1
	lw	$v1,20($fp)
	sw	$v1,0($v0)
.L5:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L3
.L4:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L2
.L2:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE1:
	.end	tig_initArray
	.align 4
	.globl	tig_allocRecord
	.ent	tig_allocRecord
tig_allocRecord:
.LFB2:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI5:
	sd	$ra,48($sp)
.LCFI6:
	sd	$fp,40($sp)
.LCFI7:
.LCFI8:
	move	$fp,$sp
.LCFI9:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$a0,16($fp)
	la	$t9,malloc
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	sw	$v0,28($fp)
	sw	$v0,24($fp)
	sw	$zero,20($fp)
.L8:
	lw	$v0,20($fp)
	lw	$v1,16($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L11
	b	.L9
.L11:
	addu	$v0,$fp,24
	lw	$v1,0($v0)
	sw	$zero,0($v1)
	addu	$v1,$v1,4
	sw	$v1,0($v0)
.L10:
	lw	$v0,20($fp)
	addu	$v1,$v0,4
	sw	$v1,20($fp)
	b	.L8
.L9:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L7
.L7:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE2:
	.end	tig_allocRecord
	.align 4
	.globl	tig_stringEqual
	.ent	tig_stringEqual
tig_stringEqual:
.LFB3:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI10:
	sd	$fp,40($sp)
.LCFI11:
.LCFI12:
	move	$fp,$sp
.LCFI13:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	bne	$v0,$v1,.L13
	li	$v0,1			# 0x1
	b	.L12
.L13:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	beq	$v0,$v1,.L14
	move	$v0,$zero
	b	.L12
.L14:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L15:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L18
	b	.L16
.L18:
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v0,0($v0)
	lbu	$v1,0($a0)
	beq	$v0,$v1,.L17
	move	$v0,$zero
	b	.L12
.L19:
.L17:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L15
.L16:
	li	$v0,1			# 0x1
	b	.L12
.L12:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE3:
	.end	tig_stringEqual
	.align 4
	.globl	tig_print
	.ent	tig_print
tig_print:
.LFB4:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI14:
	sd	$ra,48($sp)
.LCFI15:
	sd	$fp,40($sp)
.LCFI16:
.LCFI17:
	move	$fp,$sp
.LCFI18:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	sw	$v1,24($fp)
	sw	$zero,20($fp)
.L21:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L24
	b	.L22
.L24:
	lw	$v0,24($fp)
	lbu	$v1,0($v0)
	move	$a0,$v1
	la	$t9,putchar
	jal	$ra,$t9
.L23:
	lw	$v0,20($fp)
	addu	$v1,$v0,1
	sw	$v1,20($fp)
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L21
.L22:
.L20:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE4:
	.end	tig_print
	.globl	consts
	.data
	.align 4
consts:
	.word	0

	.byte	0x0
	.space	3
	.space	2040
	.globl	empty
	.align 4
empty:
	.word	0

	.byte	0x0
	.space	3
	.text
	.align 4
	.globl	main
	.ent	main
main:
.LFB5:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI19:
	sd	$ra,48($sp)
.LCFI20:
	sd	$fp,40($sp)
.LCFI21:
.LCFI22:
	move	$fp,$sp
.LCFI23:
	.set	noat
	.set	at
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,16($fp)
.L26:
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	bne	$v1,$zero,.L29
	b	.L27
.L29:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v1,$v0
	li	$v1,1			# 0x1
	sw	$v1,0($v0)
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v0,$v1
	lbu	$v1,16($fp)
	sb	$v1,4($v0)
.L28:
	lw	$v0,16($fp)
	addu	$v1,$v0,1
	sw	$v1,16($fp)
	b	.L26
.L27:
	move	$a0,$zero
	la	$t9,tig_main
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L25
.L25:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE5:
	.end	main
	.align 4
	.globl	tig_ord
	.ent	tig_ord
tig_ord:
.LFB6:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI24:
	sd	$fp,40($sp)
.LCFI25:
.LCFI26:
	move	$fp,$sp
.LCFI27:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L31
	li	$v0,-1			# 0xffffffff
	b	.L30
	b	.L32
.L31:
	lw	$v0,16($fp)
	lbu	$v1,4($v0)
	move	$v0,$v1
	b	.L30
.L32:
.L30:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE6:
	.end	tig_ord
	.align 4
	.globl	tig_chr
	.ent	tig_chr
tig_chr:
.LFB7:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI28:
	sd	$ra,48($sp)
.LCFI29:
	sd	$fp,40($sp)
.LCFI30:
.LCFI31:
	move	$fp,$sp
.LCFI32:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	bltz	$v0,.L35
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	beq	$v1,$zero,.L35
	b	.L34
.L35:
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L34:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L33
.L33:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE7:
	.end	tig_chr
	.align 4
	.globl	tig_size
	.ent	tig_size
tig_size:
.LFB8:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI33:
	sd	$fp,40($sp)
.LCFI34:
.LCFI35:
	move	$fp,$sp
.LCFI36:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	move	$v0,$v1
	b	.L36
.L36:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE8:
	.end	tig_size
.data
	.align 4
.LC0:

	.byte	0x73,0x75,0x62,0x73,0x74,0x72,0x69,0x6e
	.byte	0x67,0x28,0x5b,0x25,0x64,0x5d,0x2c,0x25
	.byte	0x64,0x2c,0x25,0x64,0x29,0x20,0x6f,0x75
	.byte	0x74,0x20,0x6f,0x66,0x20,0x72,0x61,0x6e
	.byte	0x67,0x65,0xa,0x0
	.text
	.align 4
	.globl	tig_substring
	.ent	tig_substring
tig_substring:
.LFB9:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI37:
	sd	$ra,64($sp)
.LCFI38:
	sd	$fp,56($sp)
.LCFI39:
.LCFI40:
	move	$fp,$sp
.LCFI41:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	sw	$a2,24($fp)
	lw	$v0,20($fp)
	bltz	$v0,.L39
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	addu	$v0,$v0,$v1
	lw	$v1,16($fp)
	lw	$a0,0($v1)
	slt	$v0,$a0,$v0
	bne	$v0,$zero,.L39
	b	.L38
.L39:
	lw	$v0,16($fp)
	la	$a0,.LC0
	lw	$a1,0($v0)
	lw	$a2,20($fp)
	lw	$a3,24($fp)
	la	$t9,printf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L38:
	lw	$v0,24($fp)
	li	$v1,1			# 0x1
	bne	$v0,$v1,.L40
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$v0,20($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,0($v1)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L37
.L40:
	lw	$v1,24($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,24($fp)
	sw	$v1,0($v0)
	sw	$zero,32($fp)
.L41:
	lw	$v0,32($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L44
	b	.L42
.L44:
	lw	$v0,28($fp)
	addu	$v1,$v0,4
	lw	$a0,32($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	lw	$a0,20($fp)
	lw	$a1,32($fp)
	addu	$a0,$a0,$a1
	addu	$v1,$v1,4
	addu	$a0,$v1,$a0
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L43:
	lw	$v0,32($fp)
	addu	$v1,$v0,1
	sw	$v1,32($fp)
	b	.L41
.L42:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L37
.L37:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE9:
	.end	tig_substring
	.align 4
	.globl	tig_concat
	.ent	tig_concat
tig_concat:
.LFB10:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI42:
	sd	$ra,64($sp)
.LCFI43:
	sd	$fp,56($sp)
.LCFI44:
.LCFI45:
	move	$fp,$sp
.LCFI46:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L46
	lw	$v1,20($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L46:
	lw	$v0,20($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L48
	lw	$v1,16($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L48:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	addu	$v0,$v0,$v1
	sw	$v0,28($fp)
	lw	$v1,28($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	lw	$v1,28($fp)
	sw	$v1,0($v0)
	sw	$zero,24($fp)
.L50:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L53
	b	.L51
.L53:
	lw	$v0,32($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L52:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L50
.L51:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L54:
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L57
	b	.L55
.L57:
	lw	$v0,32($fp)
	lw	$v1,16($fp)
	lw	$a0,24($fp)
	lw	$a1,0($v1)
	addu	$v1,$a0,$a1
	addu	$a0,$v0,4
	addu	$v0,$a0,$v1
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L56:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L54
.L55:
	lw	$v1,32($fp)
	move	$v0,$v1
	b	.L45
.L49:
.L47:
.L45:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE10:
	.end	tig_concat
	.align 4
	.globl	tig_not
	.ent	tig_not
tig_not:
.LFB11:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI47:
	sd	$fp,40($sp)
.LCFI48:
.LCFI49:
	move	$fp,$sp
.LCFI50:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	xori	$a0,$v0,0x0
	sltu	$v1,$a0,1
	move	$v0,$v1
	b	.L58
.L58:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE11:
	.end	tig_not
	.align 4
	.globl	tig_getchar
	.ent	tig_getchar
tig_getchar:
.LFB12:
	.frame	$fp,48,$ra		# vars= 0, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI51:
	sd	$ra,32($sp)
.LCFI52:
	sd	$fp,24($sp)
.LCFI53:
.LCFI54:
	move	$fp,$sp
.LCFI55:
	.set	noat
	.set	at
	la	$t9,getchar
	jal	$ra,$t9
	move	$a0,$v0
	la	$t9,tig_chr
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L59
.L59:
	move	$sp,$fp
	ld	$ra,32($sp)
	ld	$fp,24($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE12:
	.end	tig_getchar
tig_flush:
  j $ra
  .end tig_flush
tig_exit:
  j exit
  .end tig_exit

