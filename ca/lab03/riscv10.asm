#x & (-1 << 5)
.text
li a7, 5
ecall
mv t0, a0 #x

li t1, -1
slli t1, t1, 5
and a0, t0, t1

li a7, 1
ecall