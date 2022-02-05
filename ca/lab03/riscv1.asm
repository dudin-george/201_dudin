.text
li a7, 5
ecall
mv t0, a0
ecall
mv t1, a0

addi t2, t0, 5
addi t3, t1, -7
sub a0, t2, t3

li a7, 1
ecall