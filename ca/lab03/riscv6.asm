#x * 6 - y * 3 (do multiplication using shifts, adds, and subs)
.text
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

slli t2, t0, 1
add t3, t2, t2
add t3, t3, t2

add t4, t1, t1
add t4, t4, t1
sub a0, t3, t4

li a7, 1
ecall