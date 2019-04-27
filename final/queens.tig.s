.globl main
.data
L1234:
.word 27
.ascii "Array index out of bounds.
"
L1230:
.word 27
.ascii "Array index out of bounds.
"
L1226:
.word 27
.ascii "Array index out of bounds.
"
L1222:
.word 27
.ascii "Array index out of bounds.
"
L1218:
.word 27
.ascii "Array index out of bounds.
"
L1214:
.word 27
.ascii "Array index out of bounds.
"
L1210:
.word 27
.ascii "Array index out of bounds.
"
L1201:
.word 27
.ascii "Array index out of bounds.
"
L1192:
.word 27
.ascii "Array index out of bounds.
"
L1188:
.word 27
.ascii "Array index out of bounds.
"
L1183:
.word 2
.ascii "\n"
L1181:
.word 2
.ascii "\n"
L1176:
.word 2
.ascii " ."
L1175:
.word 2
.ascii " O"
L1174:
.word 27
.ascii "Array index out of bounds.
"
.text
tig_main:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -36
L1242:
sw $a0, -8($fp)
move $a0, $ra
sw $a0, -32($fp)
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $a3, $s6
move $a2, $s7
li $a0, 8
sw $a0, -12($fp)
addi $a0, $fp, -16
move $s6, $a0
lw $a0, -12($fp)
move $a0, $a0
li $a1, 0
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
sw $a0, 0($s6)
addi $a0, $fp, -20
move $s6, $a0
lw $a0, -12($fp)
move $a0, $a0
li $a1, 0
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
sw $a0, 0($s6)
addi $a0, $fp, -24
move $s6, $a0
lw $a1, -12($fp)
lw $a0, -12($fp)
add $a0, $a1, $a0
addi $a0, $a0, -1
move $a0, $a0
move $a0, $a0
li $a1, 0
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
sw $a0, 0($s6)
addi $a0, $fp, -28
move $s6, $a0
lw $a1, -12($fp)
lw $a0, -12($fp)
add $a0, $a1, $a0
addi $a0, $a0, -1
move $a0, $a0
move $a0, $a0
li $a1, 0
move $a1, $a1
jal tig_initArray
move $a0, $v0
move $a0, $a0
addi $a0, $a0, 4
sw $a0, 0($s6)
li $a0, 0
move $a0, $a0
move $a1, $fp
jal L1168
move $a0, $v0
move $v0, $a0
lw $a0, -32($fp)
move $ra, $a0
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $a3
move $s7, $a2
j L1241
L1241:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1168:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -24
L1420:
sw $a0, -12($fp)
sw $a1, -8($fp)
move $a0, $ra
sw $a0, -20($fp)
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $a3, $s5
move $a2, $s6
move $a1, $s7
lw $ra, -12($fp)
lw $a0, -8($fp)
lw $a0, -12($a0)
beq $ra, $a0, L1238
L1239:
li $a0, 0
move $a3, $a0
lw $a0, -8($fp)
lw $a0, -12($a0)
addi $a0, $a0, -1
move $a2, $a0
sw $a3, -16($fp)
ble $a3, $a2, L1237
L1184:
li $a0, 0
L1240:
move $v0, $a0
lw $a0, -20($fp)
move $ra, $a0
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $a3
move $s6, $a2
move $s7, $a1
j L1419
L1238:
lw $a0, -8($fp)
move $a0, $a0
jal L1167
move $a0, $v0
move $a0, $a0
j L1240
L1237:
lw $a0, -8($fp)
lw $s0, -16($a0)
lw $a1, -16($fp)
lw $a0, -4($s0)
blt $a1, $a0, L1185
L1186:
la $a0, L1188
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1187:
li $a0, 4
mult $a1, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
beqz $a0, L1193
L1194:
li $a0, 0
L1195:
bnez $a0, L1202
L1203:
li $a0, 0
L1204:
bnez $a0, L1235
L1236:
addi $a0, $a3, 1
move $a3, $a0
sw $a3, -16($fp)
blt $a3, $a2, L1237
L1421:
j L1184
L1185:
bgez $a1, L1187
L1422:
j L1186
L1193:
li $a0, 0
lw $a0, -8($fp)
lw $s0, -24($a0)
lw $a1, -16($fp)
lw $a0, -12($fp)
add $a0, $a1, $a0
move $a1, $a0
lw $a0, -4($s0)
blt $a1, $a0, L1189
L1190:
la $a0, L1192
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1191:
li $a0, 4
mult $a1, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
beqz $a0, L1196
L1197:
move $a0, $a0
j L1195
L1189:
bgez $a1, L1191
L1423:
j L1190
L1196:
li $a0, 1
j L1197
L1202:
li $a0, 0
lw $a0, -8($fp)
lw $s0, -28($a0)
lw $a0, -16($fp)
addi $a1, $a0, 7
lw $a0, -12($fp)
sub $a0, $a1, $a0
move $a1, $a0
lw $a0, -4($s0)
blt $a1, $a0, L1198
L1199:
la $a0, L1201
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1200:
li $a0, 4
mult $a1, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
beqz $a0, L1205
L1206:
move $a0, $a0
j L1204
L1198:
bgez $a1, L1200
L1424:
j L1199
L1205:
li $a0, 1
j L1206
L1235:
lw $a0, -8($fp)
lw $s1, -16($a0)
lw $s0, -16($fp)
lw $a0, -4($s1)
blt $s0, $a0, L1207
L1208:
la $a0, L1210
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1209:
li $a1, 1
li $a0, 4
mult $s0, $a0
mflo $a0
add $a0, $s1, $a0
sw $a1, 0($a0)
lw $a0, -8($fp)
lw $s0, -24($a0)
lw $a1, -16($fp)
lw $a0, -12($fp)
add $a0, $a1, $a0
move $a1, $a0
lw $a0, -4($s0)
blt $a1, $a0, L1211
L1212:
la $a0, L1214
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1213:
li $ra, 1
li $a0, 4
mult $a1, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
lw $a0, -8($fp)
lw $s0, -28($a0)
lw $a0, -16($fp)
addi $a1, $a0, 7
lw $a0, -12($fp)
sub $a0, $a1, $a0
move $a1, $a0
lw $a0, -4($s0)
blt $a1, $a0, L1215
L1216:
la $a0, L1218
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1217:
li $ra, 1
li $a0, 4
mult $a1, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
lw $a0, -8($fp)
lw $s1, -20($a0)
lw $s0, -12($fp)
lw $a0, -4($s1)
blt $s0, $a0, L1219
L1220:
la $a0, L1222
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1221:
lw $a1, -16($fp)
li $a0, 4
mult $s0, $a0
mflo $a0
add $a0, $s1, $a0
sw $a1, 0($a0)
lw $a0, -12($fp)
addi $a0, $a0, 1
move $a0, $a0
lw $a1, -8($fp)
move $a1, $a1
jal L1168
move $a0, $v0
lw $a0, -8($fp)
lw $s1, -16($a0)
lw $s0, -16($fp)
lw $a0, -4($s1)
blt $s0, $a0, L1223
L1224:
la $a0, L1226
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1225:
li $a1, 0
li $a0, 4
mult $s0, $a0
mflo $a0
add $a0, $s1, $a0
sw $a1, 0($a0)
lw $a0, -8($fp)
lw $s0, -24($a0)
lw $a1, -16($fp)
lw $a0, -12($fp)
add $a0, $a1, $a0
move $a1, $a0
lw $a0, -4($s0)
blt $a1, $a0, L1227
L1228:
la $a0, L1230
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1229:
li $ra, 0
li $a0, 4
mult $a1, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
lw $a0, -8($fp)
lw $s0, -28($a0)
lw $a0, -16($fp)
addi $a1, $a0, 7
lw $a0, -12($fp)
sub $a0, $a1, $a0
move $a1, $a0
lw $a0, -4($s0)
blt $a1, $a0, L1231
L1232:
la $a0, L1234
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1233:
li $ra, 0
li $a0, 4
mult $a1, $a0
mflo $a0
add $a0, $s0, $a0
sw $ra, 0($a0)
j L1236
L1207:
bgez $s0, L1209
L1425:
j L1208
L1211:
bgez $a1, L1213
L1426:
j L1212
L1215:
bgez $a1, L1217
L1427:
j L1216
L1219:
bgez $s0, L1221
L1428:
j L1220
L1223:
bgez $s0, L1225
L1429:
j L1224
L1227:
bgez $a1, L1229
L1430:
j L1228
L1231:
bgez $a1, L1233
L1431:
j L1232
L1419:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1167:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -12
L2027:
sw $a0, -8($fp)
move $a1, $ra
move $a1, $s0
move $a1, $s1
move $a1, $s2
move $a1, $s3
move $a1, $s4
move $a1, $s5
move $a1, $s6
move $a1, $s7
li $a0, 0
move $a1, $a0
lw $a0, -8($fp)
lw $a0, -12($a0)
addi $a0, $a0, -1
move $a2, $a0
move $a1, $a1
ble $a1, $a2, L1182
L1169:
la $a0, L1183
move $a0, $a0
jal tig_print
move $a0, $v0
move $v0, $a0
move $ra, $a1
move $s0, $a1
move $s1, $a1
move $s2, $a1
move $s3, $a1
move $s4, $a1
move $s5, $a1
move $s6, $a1
move $s7, $a1
j L2026
L1182:
li $a0, 0
move $a2, $a0
lw $a0, -8($fp)
lw $a0, -12($a0)
addi $a0, $a0, -1
move $a3, $a0
move $a2, $a2
ble $a2, $a3, L1180
L1170:
la $a0, L1181
move $a0, $a0
jal tig_print
move $a0, $v0
addi $a0, $a1, 1
move $a1, $a0
move $a1, $a1
blt $a1, $a2, L1182
L2028:
j L1169
L1180:
lw $a0, -8($fp)
lw $s0, -20($a0)
move $a1, $a1
lw $a0, -4($s0)
blt $a1, $a0, L1171
L1172:
la $a0, L1174
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1173:
li $a0, 4
mult $a1, $a0
mflo $a0
add $a0, $s0, $a0
lw $a0, 0($a0)
beq $a0, $a2, L1177
L1178:
la $a0, L1176
move $a0, $a0
L1179:
move $a0, $a0
jal tig_print
move $a0, $v0
addi $a0, $a2, 1
move $a2, $a0
move $a2, $a2
blt $a2, $a3, L1180
L2029:
j L1170
L1171:
bgez $a1, L1173
L2030:
j L1172
L1177:
la $a0, L1175
move $a0, $a0
j L1179
L2026:
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

