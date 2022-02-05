#reset the y-th bit of x to 0
#here the numeration begins from 0
.text
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

li t2, 1
sll t2, t2, t1
not t2, t2

and a0, t0, t2

li a7, 1
ecall
