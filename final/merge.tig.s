.globl main
.data
L1222:
.word 26
.ascii "Cannot access nil record.
"
L1219:
.word 1
.ascii " "
L1218:
.word 26
.ascii "Cannot access nil record.
"
L1215:
.word 2
.ascii "\n"
L1208:
.word 1
.ascii "0"
L1207:
.word 1
.ascii "-"
L1204:
.word 1
.ascii "0"
L1193:
.word 26
.ascii "Cannot access nil record.
"
L1190:
.word 26
.ascii "Cannot access nil record.
"
L1187:
.word 26
.ascii "Cannot access nil record.
"
L1184:
.word 26
.ascii "Cannot access nil record.
"
L1181:
.word 26
.ascii "Cannot access nil record.
"
L1178:
.word 26
.ascii "Cannot access nil record.
"
L1172:
.word 26
.ascii "Cannot access nil record.
"
L1164:
.word 1
.ascii "0"
L1162:
.word 26
.ascii "Cannot access nil record.
"
L1153:
.word 2
.ascii "\n"
L1152:
.word 1
.ascii " "
L1145:
.word 1
.ascii "9"
L1144:
.word 1
.ascii "0"
.text
tig_main:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -20
L1227:
sw $a0, -8($fp)
move $a0, $ra
sw $a0, -16($fp)
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $s6
move $a3, $s7
addi $a0, $fp, -12
move $a1, $a0
jal tig_getchar
move $a0, $v0
move $a0, $a0
sw $a0, 0($a1)
move $a0, $fp
jal L1166
move $a0, $v0
move $a1, $a0
addi $a0, $fp, -12
move $a2, $a0
jal tig_getchar
move $a0, $v0
move $a0, $a0
sw $a0, 0($a2)
move $a0, $fp
jal L1166
move $a0, $v0
move $a2, $a0
move $fp, $fp
move $a0, $a1
move $a1, $a2
move $a2, $fp
jal L1167
move $a0, $v0
move $a0, $a0
move $a0, $a0
move $a1, $fp
jal L1169
move $a0, $v0
move $v0, $a0
lw $a0, -16($fp)
move $ra, $a0
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $s6
move $s7, $a3
j L1226
L1226:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1169:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -20
L1349:
sw $a0, -12($fp)
sw $a1, -8($fp)
move $a0, $ra
sw $a0, -16($fp)
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $a3, $s6
move $a2, $s7
lw $a0, -12($fp)
beqz $a0, L1223
L1224:
lw $a1, -8($fp)
lw $s6, -12($fp)
bnez $s6, L1216
L1217:
la $a0, L1218
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1216:
li $a0, 4
add $a0, $s6, $a0
lw $a0, 0($a0)
move $a0, $a0
move $a1, $a1
jal L1168
move $a0, $v0
la $a0, L1219
move $a0, $a0
jal tig_print
move $a0, $v0
lw $a1, -8($fp)
lw $s6, -12($fp)
bnez $s6, L1220
L1221:
la $a0, L1222
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1220:
li $a0, 0
add $a0, $s6, $a0
lw $a0, 0($a0)
move $a0, $a0
move $a1, $a1
jal L1169
move $a0, $v0
move $a0, $a0
L1225:
move $v0, $a0
lw $a0, -16($fp)
move $ra, $a0
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $a3
move $s7, $a2
j L1348
L1223:
la $a0, L1215
move $a0, $a0
jal tig_print
move $a0, $v0
move $a0, $a0
j L1225
L1348:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1168:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -16
L1509:
move $a2, $a0
sw $a1, -8($fp)
move $a0, $ra
sw $a0, -12($fp)
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $s6
move $a3, $s7
bltz $a2, L1212
L1213:
bgtz $a2, L1209
L1210:
la $a0, L1208
move $a0, $a0
jal tig_print
move $a0, $v0
move $a0, $a0
L1211:
move $a0, $a0
L1214:
move $v0, $a0
lw $a0, -12($fp)
move $ra, $a0
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $s6
move $s7, $a3
j L1508
L1212:
la $a0, L1207
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 0
sub $a0, $a0, $a2
move $a0, $a0
move $a1, $fp
jal L1203
move $a0, $v0
move $a0, $a0
j L1214
L1209:
move $a0, $a2
move $a1, $fp
jal L1203
move $a0, $v0
move $a0, $a0
j L1211
L1508:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1203:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -20
L1623:
sw $a0, -12($fp)
sw $a1, -8($fp)
move $a0, $ra
sw $a0, -16($fp)
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $a3, $s6
move $a2, $s7
lw $a0, -12($fp)
bgtz $a0, L1205
L1206:
li $v0, 0
lw $a0, -16($fp)
move $ra, $a0
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $a3
move $s7, $a2
j L1622
L1205:
lw $a1, -12($fp)
li $a0, 10
div $a1, $a0
mflo $a0
move $a0, $a0
lw $a1, -8($fp)
move $a1, $a1
jal L1203
move $a0, $v0
lw $ra, -12($fp)
lw $a1, -12($fp)
li $a0, 10
div $a1, $a0
mflo $a1
li $a0, 10
mult $a1, $a0
mflo $a0
sub $a0, $ra, $a0
move $a1, $a0
la $a0, L1204
move $a0, $a0
jal tig_ord
move $a0, $v0
move $a0, $a0
add $a0, $a1, $a0
move $a0, $a0
jal tig_chr
move $a0, $v0
move $a0, $a0
move $a0, $a0
jal tig_print
move $a0, $v0
j L1206
L1622:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1167:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -36
L1749:
sw $a0, -16($fp)
sw $a1, -12($fp)
sw $a2, -8($fp)
move $a0, $ra
sw $a0, -20($fp)
move $a0, $s0
sw $a0, -24($fp)
move $a0, $s1
sw $a0, -28($fp)
move $a0, $s2
sw $a0, -32($fp)
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $s6
move $a3, $s7
lw $a0, -12($fp)
beqz $a0, L1200
L1201:
lw $a0, -16($fp)
beqz $a0, L1197
L1198:
lw $a1, -12($fp)
bnez $a1, L1176
L1177:
la $a0, L1178
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1176:
li $a0, 4
add $a0, $a1, $a0
lw $a0, 0($a0)
move $a1, $a0
lw $a2, -16($fp)
bnez $a2, L1179
L1180:
la $a0, L1181
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1179:
li $a0, 4
add $a0, $a2, $a0
lw $a0, 0($a0)
blt $a1, $a0, L1194
L1195:
li $a0, 8
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $s1, $a0
addi $a0, $s1, 0
move $s0, $a0
lw $a2, -8($fp)
lw $a1, -16($fp)
bnez $a1, L1191
L1192:
la $a0, L1193
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1191:
lw $a0, -12($fp)
move $a0, $a0
li $ra, 0
add $a1, $a1, $ra
lw $a1, 0($a1)
move $a1, $a1
move $a2, $a2
jal L1167
move $a0, $v0
move $a0, $a0
sw $a0, 0($s0)
addi $a0, $s1, 4
move $a1, $a0
lw $a2, -16($fp)
bnez $a2, L1188
L1189:
la $a0, L1190
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1188:
li $a0, 4
add $a0, $a2, $a0
lw $a0, 0($a0)
sw $a0, 0($a1)
move $a0, $s1
L1196:
move $a0, $a0
L1199:
move $a0, $a0
L1202:
move $v0, $a0
lw $a0, -20($fp)
move $ra, $a0
lw $a0, -24($fp)
move $s0, $a0
lw $a0, -28($fp)
move $s1, $a0
lw $a0, -32($fp)
move $s2, $a0
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $s6
move $s7, $a3
j L1748
L1200:
lw $a0, -16($fp)
j L1202
L1197:
lw $a0, -12($fp)
j L1199
L1194:
li $a0, 8
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $s1, $a0
addi $a0, $s1, 0
move $s0, $a0
lw $a2, -8($fp)
lw $a1, -16($fp)
lw $s2, -12($fp)
bnez $s2, L1185
L1186:
la $a0, L1187
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1185:
li $a0, 0
add $a0, $s2, $a0
lw $a0, 0($a0)
move $a0, $a0
move $a1, $a1
move $a2, $a2
jal L1167
move $a0, $v0
move $a0, $a0
sw $a0, 0($s0)
addi $a0, $s1, 4
move $a1, $a0
lw $a2, -12($fp)
bnez $a2, L1182
L1183:
la $a0, L1184
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1182:
li $a0, 4
add $a0, $a2, $a0
lw $a0, 0($a0)
sw $a0, 0($a1)
move $a0, $s1
j L1196
L1748:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1166:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -24
L2081:
sw $a0, -8($fp)
move $a0, $ra
sw $a0, -20($fp)
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $a3, $s6
move $a2, $s7
addi $a0, $fp, -12
move $a1, $a0
li $a0, 4
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $a0, $a0
li $ra, 0
sw $ra, 0($a0)
sw $a0, 0($a1)
addi $a0, $fp, -16
move $s6, $a0
lw $a0, -12($fp)
move $a0, $a0
lw $a1, -8($fp)
move $a1, $a1
jal L1141
move $a0, $v0
move $a0, $a0
sw $a0, 0($s6)
lw $a1, -12($fp)
bnez $a1, L1170
L1171:
la $a0, L1172
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1170:
li $a0, 0
add $a0, $a1, $a0
lw $a0, 0($a0)
bnez $a0, L1173
L1174:
li $a0, 0
L1175:
move $v0, $a0
lw $a0, -20($fp)
move $ra, $a0
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $s5
move $s6, $a3
move $s7, $a2
j L2080
L1173:
li $a0, 8
move $a0, $a0
jal tig_allocRecord
move $a0, $v0
move $s6, $a0
addi $a0, $s6, 0
move $a1, $a0
lw $a0, -8($fp)
move $a0, $a0
jal L1166
move $a0, $v0
move $a0, $a0
sw $a0, 0($a1)
lw $a0, -16($fp)
sw $a0, 4($s6)
move $a0, $s6
j L1175
L2080:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1141:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -12
L2245:
move $a2, $a0
sw $a1, -8($fp)
move $a0, $ra
move $a0, $s0
move $a0, $s1
move $a0, $s2
move $a0, $s3
move $a0, $s4
move $a0, $s5
move $a0, $s6
move $a0, $s7
li $a3, 0
move $a0, $fp
jal L1143
move $a0, $v0
move $a1, $a2
bnez $a1, L1160
L1161:
la $a0, L1162
move $a0, $a0
jal tig_print
move $a0, $v0
li $a0, 1
move $a0, $a0
jal tig_exit
move $a0, $v0
L1160:
li $a0, 0
add $a0, $a1, $a0
move $a2, $a0
lw $a0, -8($fp)
lw $a0, -12($a0)
move $a0, $a0
move $a1, $fp
jal L1142
move $a0, $v0
move $a0, $a0
sw $a0, 0($a2)
lw $a0, -8($fp)
lw $a0, -12($a0)
move $a0, $a0
move $a1, $fp
jal L1142
move $a0, $v0
move $a0, $a0
bnez $a0, L1165
L1163:
move $v0, $a3
move $ra, $a0
move $s0, $a0
move $s1, $a0
move $s2, $a0
move $s3, $a0
move $s4, $a0
move $s5, $a0
move $s6, $a0
move $s7, $a0
j L2244
L1165:
li $a0, 10
mult $a3, $a0
mflo $a0
move $a1, $a0
lw $a0, -8($fp)
lw $a0, -12($a0)
move $a0, $a0
jal tig_ord
move $a0, $v0
move $a0, $a0
add $a0, $a1, $a0
move $a1, $a0
la $a0, L1164
move $a0, $a0
jal tig_ord
move $a0, $v0
move $a0, $a0
sub $a0, $a1, $a0
move $a3, $a0
lw $a0, -8($fp)
addi $a0, $a0, -12
move $a1, $a0
jal tig_getchar
move $a0, $v0
move $a0, $a0
sw $a0, 0($a1)
lw $a0, -8($fp)
lw $a0, -12($a0)
move $a0, $a0
move $a1, $fp
jal L1142
move $a0, $v0
move $a0, $a0
bnez $a0, L1165
L2246:
j L1163
L2244:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1143:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -12
L2344:
sw $a0, -8($fp)
move $a0, $ra
move $a0, $s0
move $a0, $s1
move $a0, $s2
move $a0, $s3
move $a0, $s4
move $a0, $s5
move $a0, $s6
move $a0, $s7
lw $a0, -8($fp)
lw $a0, -8($a0)
lw $a1, -12($a0)
la $a0, L1152
beq $a1, $a0, L1154
L1155:
li $a0, 0
lw $a0, -8($fp)
lw $a0, -8($a0)
lw $a1, -12($a0)
la $a0, L1153
beq $a1, $a0, L1157
L1158:
move $a0, $a0
L1156:
bnez $a0, L1159
L1151:
li $v0, 0
move $ra, $a0
move $s0, $a0
move $s1, $a0
move $s2, $a0
move $s3, $a0
move $s4, $a0
move $s5, $a0
move $s6, $a0
move $s7, $a0
j L2343
L1154:
li $a0, 1
j L1156
L1157:
li $a0, 1
j L1158
L1159:
lw $a0, -8($fp)
lw $a0, -8($a0)
addi $a0, $a0, -12
move $a1, $a0
jal tig_getchar
move $a0, $v0
move $a0, $a0
sw $a0, 0($a1)
lw $a0, -8($fp)
lw $a0, -8($a0)
lw $a1, -12($a0)
la $a0, L1152
beq $a1, $a0, L1154
L2345:
j L1155
L2343:
move $sp, $fp
lw $fp, 0($sp)
jr $ra
L1142:
sw $fp, 0($sp)
move $fp, $sp
addiu $sp, $sp, -16
L2406:
move $a0, $a0
sw $a1, -8($fp)
move $a0, $ra
sw $a0, -12($fp)
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $a3, $s5
move $a2, $s6
move $a1, $s7
lw $a0, -8($fp)
lw $a0, -8($a0)
lw $a0, -12($a0)
move $a0, $a0
jal tig_ord
move $a0, $v0
move $a0, $a0
move $s5, $a0
la $a0, L1144
move $a0, $a0
jal tig_ord
move $a0, $v0
move $a0, $a0
bge $s5, $a0, L1146
L1147:
li $a0, 0
L1148:
move $v0, $a0
lw $a0, -12($fp)
move $ra, $a0
move $s0, $s0
move $s1, $s1
move $s2, $s2
move $s3, $s3
move $s4, $s4
move $s5, $a3
move $s6, $a2
move $s7, $a1
j L2405
L1146:
li $a0, 0
lw $a0, -8($fp)
lw $a0, -8($a0)
lw $a0, -12($a0)
move $a0, $a0
jal tig_ord
move $a0, $v0
move $a0, $a0
move $s5, $a0
la $a0, L1145
move $a0, $a0
jal tig_ord
move $a0, $v0
move $a0, $a0
ble $s5, $a0, L1149
L1150:
move $a0, $a0
j L1148
L1149:
li $a0, 1
j L1150
L2405:
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

