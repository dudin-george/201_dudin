#(x / y) * y + x % y
.text
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

div t2, t0, t1
mul t2, t2, t1
rem t3, t0, t1

add a0, t2, t3

li a7, 1
ecall