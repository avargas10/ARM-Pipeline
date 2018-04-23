mov r1, #8
mov r2, #2
str r2, [r1,#0]
ldr r3, [r1,#0]
cmp     r3, r2
beq     label
label 
    add r5,r2,#4