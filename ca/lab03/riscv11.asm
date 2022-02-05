#x | (-1 >> 27) (>> - logical shift)
.text
li a7, 5
ecall
mv t0, a0 #x

li t1, -1
srli t1, t1, 27
or a0, t0, t1

li a7, 1
ecall