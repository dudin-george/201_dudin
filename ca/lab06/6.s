# Example library of macros.
   .macro print_int (%x)
   li a7, 1
   mv a0, %x
   ecall
   .end_macro

   .macro print_float (%x)
   li a7, 2
   fmv.s fa0, %x
   ecall
   .end_macro

   
  .macro print_intu (%x)
   li a7, 36
   mv a0, %x
   ecall
   .end_macro

   .macro print_imm_int (%x)
   li a7, 1
   li a0, %x
   ecall
   .end_macro

   .macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
   .end_macro

   .macro read_float(%x)
   li a7, 6
   fmv.s %x, fa0
   ecall
   .end_macro

   .macro read_char(%x)
   li a7, 12
   ecall
   mv %x, a0
   .end_macro

   .macro print_str (%x)
   .data
str:
   .asciz %x
   .text
   li a7, 4
   la a0, str
   ecall
   .end_macro

   .macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
   .end_macro

   .macro newline
   print_char('\n')
   .end_macro




   .macro printline(%x, %y, %z)
   mv t0, %x
   beqz t0, end
   print_char(%y)
   for:
   beqz t0, end
   addi t0, t0, -1
   print_char(%z)
   print_char(%y)
   j for
   end:
   .end_macro

#hw6lib.s
.macro less_or_equal(%x,%y)
li a0, 0
bgt %x, %y, end
li a0, 1
end:
.end_macro

.macro three_numbers_equal(%x,%y,%z)
li a0, 0
bne %x, %y, end
bne %y, %z, end
li a0, 1
end:
.end_macro


.macro check_triangle(%x,%y,%z)
add a1, %y, %z
add a2, %x, %z
add a3, %x, %y

three_numbers_equal(%x, %y, %z)
beqz a0, main
li a0, 0
j end
main:

less_or_equal(%x, a1)
mv a4, a0
less_or_equal(%y, a2)
mv a5, a0
less_or_equal(%z, a3)
mv a6, a0

and a4, a4, a5
and a4, a4, a6

bnez a4, not_zero
li a0, 2
j end
not_zero:
li a0, 1
end:
.end_macro


#prob1
.include "macrolib.s"
.text
read_int(t0)
read_int(t1)

mv t6, t0

addi t6, t6, 1
addi t1, t1, -1
printline(t1,'+','-')
for:
beqz t6, end
addi t6, t6, -1
newline
printline(t1,'|',' ')
newline
printline(t1,'+','-')
j for
end:

#prob2
.include "macrolib.s"
.include "hw6lib.s"
.text


li t6, 1
for:
beqz t6, end
read_int(t0)
read_int(t1)
read_int(t2)
check_triangle(t0,t1,t2)
mv t6, a0
li t5, 1

bnez t6, not_zero
j for
not_zero:
bne t6,t5,  not_unit
print_char('Y')
newline
j for
not_unit:
print_char('N')
newline
j for
end:
#prob3
.include "../macrolib.s"
.text

    li a6, 4
    read_int(t0)
    mv t1, sp
    mv t6, t0
loop:
    beqz t0, out_loop
    addi t0, t0, -1
    
    read_int(t3)
    addi sp, sp, -4
    sw t3, 4(sp)
    j loop
out_loop:
    mv t2, sp

    mv a1, t6
    addi a1, a1, -1
    mv a2, t6
    addi a2, a2, -1

    
    mv t4, zero
next_t0:
    beq t4, a1, end_for_t0
    mv t5, zero
    
    mv s6, a2
next_t1:
    beq t5, s6, end_for_t1
    # inside
    
    mul a3, t5, a6
    mul a4, t5, a6
    addi a4, a4, 4
    
    neg a3, a3
    neg a4, a4
    
    add a3, t1, a3
    add a4, t1, a4
    
    lw s0, 0(a3)
    lw s1, 0(a4)
    
    
    ble s0, s1, more
    swap_m(a3,a4)
    more:
    
    #
    
    addi, t5, t5, 1
    j next_t1
end_for_t1:
    #outer
    addi t4, t4, 1
    j next_t0
end_for_t0:





mv sp, t1
print_for:
beqz t6, end_for
addi t6, t6, -1
lw t0, 0(sp)
print_int(t0)
print_char(' ')
addi sp, sp, -4
j print_for
end_for:
#prob4
.include "../macrolib.s"
.text
    li a5, 10
    j main
    
    #read_int(t0)
    
key_sort:
    mv t0, a0
    mv s9, a1
    mv s8, ra
    
    li a6, 4
    
    mv t1, sp
    mv t6, t0
loop:
    beqz t0, out_loop
    addi t0, t0, -1
    
    read_int(t3)
    addi sp, sp, -4
    sw t3, 4(sp)
    j loop
out_loop:
    mv t2, sp

    mv s5, t6
    addi s5, s5, -1
    mv a2, t6
    addi a2, a2, -1

    
    mv t4, zero
next_t0:
    beq t4, s5, end_for_t0
    mv t5, zero
    
    mv s6, a2
next_t1:
    beq t5, s6, end_for_t1
    
    mul a3, t5, a6
    mul a4, t5, a6
    addi a4, a4, 4
    
    neg a3, a3
    neg a4, a4
    
    add a3, t1, a3
    add a4, t1, a4
    
    lw s0, 0(a3)
    lw s1, 0(a4)
    
    
    
    beqz s9, bzero
    
    mv a0, s0
    mv a1, s1
    jal more_rem10
    bnez a0, go_rem
    j more
    go_rem:
    swap_m(a3,a4)
    j more
    
    bzero:
    mv a0, s0
    mv a1, s1
    jal less_than
    beqz a0, go_less
    j more
    go_less:
    swap_m(a3,a4)
    j more
    
    
    more:
    
    addi, t5, t5, 1
    j next_t1
    #
end_for_t1:
    #outer
    addi t4, t4, 1
    j next_t0
end_for_t0:





mv sp, t1
print_for:
beqz t6, end_for
addi t6, t6, -1
lw t0, 0(sp)
print_int(t0)
newline
addi sp, sp, -4
j print_for
end_for:
mv ra, s8
jr ra


less_than:
    blt a0, a1, lt
    li a0, 0
    jr ra
    lt:
    li a0, 1
    jr ra

more_rem10:
    rem a0, a0, a5
    rem a1, a1, a5
    bge a0, a1, gt
    li a0, 1
    jr ra
    gt:
    li a0, 0
    jr ra
    

main:
read_int(t0)
read_int(a1)
mv a0, t0

jal key_sort
#prob5
.include "../macrolib.s"
.data
array:
    .word 0, 10, 12, 14, 99, 1000, 1005, 9000, 9595
    .text
    
j main

binary_search:
mv s0, ra
la t1, array
addi sp, sp, -8
sw s0, 0(sp)
sw t1, 4(sp)

li t6, 2

sub t0, a2, a1
div t0, t0, t6
add t0, a1, t0

bge a1, a2, next1
li a0, -1


lw s0, 0(sp)
lw t1, 4(sp)
addi sp, sp, 8
mv ra, s0

jr ra
next1:
mul t4, t6, t6
mul t4, t1, t6
add t3, t0, t1
lw t1, 0(t3)

bne t1, a0, next2
mv a0, t1

addi sp, sp, 4
lw s0, 0(sp)
lw t1, 4(sp)
mv ra, s0

jr ra
next2:
ble t1, a0, next3
mv t5, a2
addi a2, t1, -1
jal binary_search
mv a2, t5
next3:
mv t5, a1
addi a1, t1, 1
jal binary_search
mv a1, t5
j end


main:
li a0,0
li a1, 0
li a2, 8
jal binary_search
print_int(a0)

end:
