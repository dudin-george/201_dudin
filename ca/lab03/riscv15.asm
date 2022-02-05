#(x == (y + 3)) ? 0 : 1
.text
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

addi t1, t1, 3
sub t2, t0, t1
snez a0, t2

li a7, 1
ecall