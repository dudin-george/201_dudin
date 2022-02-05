#x << y - 10
.text
li a7, 5
ecall
mv t0, a0
ecall
mv t1, a0

addi t2, t1, -10
sll a0, t0, t2

li a7, 1
ecall
