.globl main
.data
L2776:
.word 27
.ascii "Array index out of bounds.
"
L2772:
.word 26
.ascii "Cannot access nil record.
"
L2769:
.word 27
.ascii "Array index out of bounds.
"
L2765:
.word 26
.ascii "Cannot access nil record.
"
L2762:
.word 27
.ascii "Array index out of bounds.
"
L2758:
.word 26
.ascii "Cannot access nil record.
"
L2755:
.word 27
.ascii "Array index out of bounds.
"
L2751:
.word 26
.ascii "Cannot access nil record.
"
L2748:
.word 3
.ascii "sdf"
L2747:
.word 26
.ascii "Cannot access nil record.
"
L2744:
.word 3
.ascii "sfd"
L2743:
.word 27
.ascii "Array index out of bounds.
"
L2739:
.word 26
.ascii "Cannot access nil record.
"
L2736:
.word 27
.ascii "Array index out of bounds.
"
L2732:
.word 26
.ascii "Cannot access nil record.
"
L2729:
.word 27
.ascii "Array index out of bounds.
"
L2725:
.word 4
.ascii "kati"
L2724:
.word 26
.ascii "Cannot access nil record.
"
L2721:
.word 27
.ascii "Array index out of bounds.
"
L2717:
.word 26
.ascii "Cannot access nil record.
"
L2714:
.word 27
.ascii "Array index out of bounds.
"
L2710:
.word 27
.ascii "Array index out of bounds.
"
L2706:
.word 27
.ascii "Array index out of bounds.
"
L2702:
.word 5
.ascii "Allos"
L2701:
.word 5
.ascii "Kapou"
L2700:
.word 7
.ascii "Kapoios"
L2699:
.word 0
.ascii ""
L2698:
.word 9
.ascii "somewhere"
L2697:
.word 5
.ascii "aname"
.text
tig_main:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -36
L2778:
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
la $a0, L2698
sw $a0, 8($ra)
la $a0, L2697
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
la $a1, L2699
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
la $a1, L2701
sw $a1, 8($a0)
la $a1, L2700
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
la $a0, L2702
sw $a0, 4($s0)
move $a1, $s0
move $s0, $s4
li $s6, 0
lw $a0, -4($s0)
blt $s6, $a0, L2703
L2704:
la $a0, L2706
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2705:
li $ra, 1
li $a0, 4
mult $s6, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s4
li $s4, 9
lw $a0, -4($s0)
blt $s4, $a0, L2707
L2708:
la $a0, L2710
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2709:
li $ra, 3
li $a0, 4
mult $s4, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s3
li $s4, 3
lw $a0, -4($s0)
blt $s4, $a0, L2711
L2712:
la $a0, L2714
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2713:
li $a0, 4
mult $s4, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $s0, $a0
bnez $s0, L2715
L2716:
la $a0, L2717
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2715:
li $a0, 12
add $a0, $s0, $a0
lw $a0, 0($a0)
move $a0, $a0
jal tig_print
move $a0, $v0
move $s0, $s3
li $s4, 3
lw $a0, -4($s0)
blt $s4, $a0, L2718
L2719:
la $a0, L2721
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2720:
li $a0, 4
mult $s4, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $s0, $a0
bnez $s0, L2722
L2723:
la $a0, L2724
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2722:
la $ra, L2725
li $a0, 12
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s3
li $s4, 3
lw $a0, -4($s0)
blt $s4, $a0, L2726
L2727:
la $a0, L2729
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2728:
li $a0, 4
mult $s4, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $s0, $a0
bnez $s0, L2730
L2731:
la $a0, L2732
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2730:
li $a0, 12
add $a0, $s0, $a0
lw $a0, 0($a0)
move $a0, $a0
jal tig_print
move $a0, $v0
move $s0, $s3
li $s3, 1
lw $a0, -4($s0)
blt $s3, $a0, L2733
L2734:
la $a0, L2736
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2735:
li $a0, 4
mult $s3, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
move $s0, $a0
bnez $s0, L2737
L2738:
la $a0, L2739
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2737:
li $ra, 23
li $a0, 0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s2
li $s2, 34
lw $a0, -4($s0)
blt $s2, $a0, L2740
L2741:
la $a0, L2743
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2742:
la $ra, L2744
li $a0, 4
mult $s2, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $s0, $s1
bnez $s0, L2745
L2746:
la $a0, L2747
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2745:
la $ra, L2748
li $a0, 12
add $a0, $s0, $a0
sw $ra, 0($a0)
move $a1, $a1
bnez $a1, L2749
L2750:
la $a0, L2751
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2749:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
move $s0, $a0
li $s1, 0
lw $a0, -4($s0)
blt $s1, $a0, L2752
L2753:
la $a0, L2755
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2754:
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
bnez $a1, L2756
L2757:
la $a0, L2758
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2756:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
move $s0, $a0
li $s1, 0
lw $a0, -4($s0)
blt $s1, $a0, L2759
L2760:
la $a0, L2762
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2761:
li $ra, 74
li $a0, 4
mult $s1, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
move $a1, $a1
bnez $a1, L2763
L2764:
la $a0, L2765
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2763:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
move $s0, $a0
li $s1, 0
lw $a0, -4($s0)
blt $s1, $a0, L2766
L2767:
la $a0, L2769
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2768:
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
bnez $a1, L2770
L2771:
la $a0, L2772
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2770:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
move $a1, $a0
li $s0, 2
lw $a0, -4($a1)
blt $s0, $a0, L2773
L2774:
la $a0, L2776
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L2775:
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
j L2777
L2703:
bgez $s6, L2705
L2779:
j L2704
L2707:
bgez $s4, L2709
L2780:
j L2708
L2711:
bgez $s4, L2713
L2781:
j L2712
L2718:
bgez $s4, L2720
L2782:
j L2719
L2726:
bgez $s4, L2728
L2783:
j L2727
L2733:
bgez $s3, L2735
L2784:
j L2734
L2740:
bgez $s2, L2742
L2785:
j L2741
L2752:
bgez $s1, L2754
L2786:
j L2753
L2759:
bgez $s1, L2761
L2787:
j L2760
L2766:
bgez $s1, L2768
L2788:
j L2767
L2773:
bgez $s0, L2775
L2789:
j L2774
L2777:
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

