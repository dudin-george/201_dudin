#(x + 5) / y + 10 / (y - 1)
.text
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

addi t0, t0, 5
addi t2, t1, 10
addi t1, t1, -1

div a0, t0, t2
div a0, a0, t1

li a7, 1
ecall