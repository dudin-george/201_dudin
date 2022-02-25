ex.1
.macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
   .end_macro
 
 read_int(a1)
addi t1, zero, 1
li t2, 10
read_int(a2)
read_int(a3)

   
   
   

fcvt.d.w fa2, a2
fcvt.d.w fa1, a1
fdiv.d fa3, fa1, fa2



PreparetheNum:

beqz a3, Delete
addi a3,a3,-1
mul t1, t1, t2

j PreparetheNum

Delete:

fcvt.d.w ft1, t1
fmul.d fa3, fa3, ft1
fcvt.w.d a3, fa3
fcvt.d.w fa3, a3
fdiv.d fa3, fa3, ft1

.macro printF(%x)
   li a7, 3
   fmv.d fa0, %x
   ecall
   .end_macro
   
printF(fa3)


ex.2
.text 
li t0, 2
li t1, 0

  .macro read_double(%x)
   li a7, 7
   ecall
   fmv.d %x, fa0
   .end_macro
  .text
read_double(fa5) 
read_double(fa1)


fcvt.d.w ft1, t1
fmv.d fs1, fa5
fcvt.d.w ft0, t0

FindNumber:

fadd.d fa3, ft1, fs1
fdiv.d fa3, fa3, ft0
fmv.d fs10, fa3
fmul.d fs2, fa3,fa3

fmul.d fs3,fa3,fs2
fabs.d fs3,fs3
fabs.d fs11, fa5
fsub.d fa3, fs11, fs3
fabs.d fa3, fa3
fle.d a3, fa3, fa1
bgtz a3, end

fge.d a3, fs3, fa5
bgtz  a3, ifMore
fmv.d ft1, fs10
j FindNumber

ifMore:
fmv.d fs1, fs10
j FindNumber


end:
.macro print_double(%a)
   li a7, 3
   fmv.d fa0, %a
   ecall
   .end_macro
print_double(fs10)

