#(x << 2 - y + 5) >> 1 (>> - arithmetical shift)
#i assume that both shifts are of lesser arithmetic priority, the same goes for previous tasks
#please do not punch me in the nutz if that was not the interpretation that you had in mind
#and write more clear instructions instead
.text
li a7, 5
ecall
mv t0, a0 #x
ecall
mv t1, a0 #y

li t2, 2
sub t2, t2, t1
addi t2, t2, 5
sll t3, t0, t2
srli a0, t3, 1

li a7, 1
ecall