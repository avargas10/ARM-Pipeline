    ;salto de linea para las filas de la imagen
    mov r1,#180
    mov r2,#181
    mov r3,#0
    mov r9,#3
    x   matMult
    ldr r5,[r1],#1;extrae el dato en r1+4 de memoria
    ldr r6,[r2],#1;extrae el dato en r2+4 de memoria
    mul r7,r5,r6 ;se multiplican los datos
    add r8,r8,r7 ;se almacena el dato para la suma de las multiplicaciones 
    mov r7,#0;limpia r7
    sub r9,r9,#1;se disminuye el contador
    cmp r9,#0 ;se evalua si se termino el proceso
    bne matMult
    str r8,[r3],#1