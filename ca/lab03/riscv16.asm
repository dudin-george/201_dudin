#x < -5 & y > 10
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

addi t1, t1, -10
addi t0, t0, 5

sltz t2, t0
sgtz t3, t1
and a0, t2, t3

li a7, 1
ecall