#2 * x * x - 3 * y + 4
.text
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

mul t0, t0, t0
add t0, t0, t0

add t4, t1, t1
add t4, t4, t1
sub t3, t0, t4

addi a0, t3, 4

li a7, 1
ecall