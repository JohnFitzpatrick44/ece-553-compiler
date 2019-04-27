.globl main
.data
L129:
.word 27
.ascii "Array index out of bounds.
"
L125:
.word 26
.ascii "Cannot access nil record.
"
L122:
.word 27
.ascii "Array index out of bounds.
"
L118:
.word 26
.ascii "Cannot access nil record.
"
L115:
.word 27
.ascii "Array index out of bounds.
"
L111:
.word 26
.ascii "Cannot access nil record.
"
L108:
.word 27
.ascii "Array index out of bounds.
"
L104:
.word 26
.ascii "Cannot access nil record.
"
L101:
.word 3
.ascii "sdf"
L100:
.word 26
.ascii "Cannot access nil record.
"
L97:
.word 3
.ascii "sfd"
L96:
.word 27
.ascii "Array index out of bounds.
"
L92:
.word 26
.ascii "Cannot access nil record.
"
L89:
.word 27
.ascii "Array index out of bounds.
"
L85:
.word 26
.ascii "Cannot access nil record.
"
L82:
.word 27
.ascii "Array index out of bounds.
"
L78:
.word 4
.ascii "kati"
L77:
.word 26
.ascii "Cannot access nil record.
"
L74:
.word 27
.ascii "Array index out of bounds.
"
L70:
.word 26
.ascii "Cannot access nil record.
"
L67:
.word 27
.ascii "Array index out of bounds.
"
L63:
.word 27
.ascii "Array index out of bounds.
"
L59:
.word 27
.ascii "Array index out of bounds.
"
L55:
.word 5
.ascii "Allos"
L54:
.word 5
.ascii "Kapou"
L53:
.word 7
.ascii "Kapoios"
L52:
.word 0
.ascii ""
L51:
.word 9
.ascii "somewhere"
L50:
.word 5
.ascii "aname"
.text
tig_main:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -36
L131:
sw $a0, -8($fp)
move $a0, $ra
sw $a0, -12($fp)
move $a0, $s0
sw $a0, -16($fp)
move $a0, $s1
sw $a0, -20($fp)
move $a0, $s2
sw $a0, -24($fp)
move $a0, $s3
sw $a0, -28($fp)
move $a0, $s4
sw $a0, -32($fp)
move $s5, $s5
move $a3, $s6
move $a2, $s7
li $a0, 10
move $a0, $a0
li $a1, 0
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
move $s4, $a0
li $a1, 5
li $a0, 16
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $ra, $a0
li $a0, 0
sw $a0, 0($ra)
li $a0, 0
sw $a0, 4($ra)
la $a0, L51
sw $a0, 8($ra)
la $a0, L50
sw $a0, 12($ra)
move $a0, $a1
move $a1, $ra
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
move $s3, $a0
li $a0, 100
move $a0, $a0
la $a1, L52
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
move $s2, $a0
li $a0, 16
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $a0, $a0
li $a1, 44
sw $a1, 0($a0)
li $a1, 2432
sw $a1, 4($a0)
la $a1, L54
sw $a1, 8($a0)
la $a1, L53
sw $a1, 12($a0)
move $s1, $a0
li $a0, 8
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $s0, $a0
addi $a0, $s0, 0
move $s6, $a0
li $a0, 3
move $a0, $a0
li $a1, 70
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
sw $a0, 0($s6)
la $a0, L55
sw $a0, 4($s0)
move $a1, $s0
move $s0, $s4
li $s6, 0
lw $a0, -4($s0)
blt $s6, $a0, L56
L57:
la $a0, L59
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L58:
li $ra, 1
li $a0, 4
mult $s6, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s4
li $s4, 9
lw $a0, -4($s0)
blt $s4, $a0, L60
L61:
la $a0, L63
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L62:
li $ra, 3
li $a0, 4
mult $s4, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s3
li $s4, 3
lw $a0, -4($s0)
blt $s4, $a0, L64
L65:
la $a0, L67
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L66:
li $a0, 4
mult $s4, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $s0, $a0
bnez $s0, L68
L69:
la $a0, L70
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L68:
li $a0, 12
add $a0, $s0, $a0
lw $a0, 0($a0)
move $a0, $a0
jal tig_print
move $a0, $v0
move $s0, $s3
li $s4, 3
lw $a0, -4($s0)
blt $s4, $a0, L71
L72:
la $a0, L74
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L73:
li $a0, 4
mult $s4, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $s0, $a0
bnez $s0, L75
L76:
la $a0, L77
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L75:
la $ra, L78
li $a0, 12
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s3
li $s4, 3
lw $a0, -4($s0)
blt $s4, $a0, L79
L80:
la $a0, L82
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L81:
li $a0, 4
mult $s4, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $s0, $a0
bnez $s0, L83
L84:
la $a0, L85
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L83:
li $a0, 12
add $a0, $s0, $a0
lw $a0, 0($a0)
move $a0, $a0
jal tig_print
move $a0, $v0
move $s0, $s3
li $s3, 1
lw $a0, -4($s0)
blt $s3, $a0, L86
L87:
la $a0, L89
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L88:
li $a0, 4
mult $s3, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $s0, $a0
bnez $s0, L90
L91:
la $a0, L92
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L90:
li $ra, 23
li $a0, 0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s2
li $s2, 34
lw $a0, -4($s0)
blt $s2, $a0, L93
L94:
la $a0, L96
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L95:
la $ra, L97
li $a0, 4
mult $s2, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s1
bnez $s0, L98
L99:
la $a0, L100
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L98:
la $ra, L101
li $a0, 12
add $a0, $s0, $a0
sw $ra, 0($a0)
move $a1, $a1
bnez $a1, L102
L103:
la $a0, L104
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L102:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
move $s0, $a0
li $s1, 0
lw $a0, -4($s0)
blt $s1, $a0, L105
L106:
la $a0, L108
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L107:
li $a0, 4
mult $s1, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $a0, $a0
jal tig_chr
move $a0, $v0
move $a0, $a0
move $a0, $a0
jal tig_print
move $a0, $v0
move $a1, $a1
bnez $a1, L109
L110:
la $a0, L111
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L109:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
move $s0, $a0
li $s1, 0
lw $a0, -4($s0)
blt $s1, $a0, L112
L113:
la $a0, L115
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L114:
li $ra, 74
li $a0, 4
mult $s1, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $a1, $a1
bnez $a1, L116
L117:
la $a0, L118
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L116:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
move $s0, $a0
li $s1, 0
lw $a0, -4($s0)
blt $s1, $a0, L119
L120:
la $a0, L122
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L121:
li $a0, 4
mult $s1, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $a0, $a0
jal tig_chr
move $a0, $v0
move $a0, $a0
move $a0, $a0
jal tig_print
move $a0, $v0
move $a1, $a1
bnez $a1, L123
L124:
la $a0, L125
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L123:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
move $a1, $a0
li $s0, 2
lw $a0, -4($a1)
blt $s0, $a0, L126
L127:
la $a0, L129
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L128:
li $ra, 2323
li $a0, 4
mult $s0, $a0
mflo $a0
add $a0, $a1, $a0
sw $ra, 0($a0)
li $v0, 0
lw $a0, -12($fp)
move $ra, $a0
lw $a0, -16($fp)
move $s0, $a0
lw $a0, -20($fp)
move $s1, $a0
lw $a0, -24($fp)
move $s2, $a0
lw $a0, -28($fp)
move $s3, $a0
lw $a0, -32($fp)
move $s4, $a0
move $s5, $s5
move $s6, $a3
move $s7, $a2
j L130
L56:
bgez $s6, L58
L132:
j L57
L60:
bgez $s4, L62
L133:
j L61
L64:
bgez $s4, L66
L134:
j L65
L71:
bgez $s4, L73
L135:
j L72
L79:
bgez $s4, L81
L136:
j L80
L86:
bgez $s3, L88
L137:
j L87
L93:
bgez $s2, L95
L138:
j L94
L105:
bgez $s1, L107
L139:
j L106
L112:
bgez $s1, L114
L140:
j L113
L119:
bgez $s1, L121
L141:
j L120
L126:
bgez $s0, L128
L142:
j L127
L130:
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

