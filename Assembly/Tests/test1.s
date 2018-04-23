mov r7,#1;limpia r7
mov r10,#3
jumpLine mov r9,#3
matMult add r8,r8,r7 ;se almacena el dato para la suma de las multiplicaciones
sub r9,r9,#1;se disminuye el contador
cmp r9,#0 ;se evalua si se termino el proceso   
bne matMult
add r2,r2,#50
sub r10,r10,#1;se disminuye el contador
cmp r10,#0 ;se evalua si se termino el proceso
bne jumpLine

