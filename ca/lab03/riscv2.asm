#x >> 2 + (y - 1) << 3 (>> - logical shift)	
#i am solving this task on the presumption that bitwise shifts have the least arithmetic priority
.text
li a7, 5
ecall
mv t0, a0
ecall
mv t1, a0

addi t2, t1, -1
addi t3, t2, 2
srl t4, t0, t3
slli a0, t4, 3

li a7, 1
ecall