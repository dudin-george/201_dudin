#x > y ? 0 : 1
.text
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

bgt t0, t1, zerocase
li a0, 1
j end
zerocase:
li a0, 0
end:
li a7, 1
ecall