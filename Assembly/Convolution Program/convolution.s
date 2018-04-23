//Carga de valores definidos
mov r1,#0 //kernel position 
mov r11,#100 //original image pos
mov r3,#3100 //new image pos
mov r4,#52 //image size
//Proceso de convolucion
//salto de filas
mov r14,0
ymapping
mul r13,r4,r14
mov r12,#0//se limpia el contador 
//salto colunmas
xMapping
add r2,r13,r12
mov r1,#0
mov r10,#3
//matriz 3x3 por otra 3x3
jumpLine
mov r9,#3
//salto de linea para las filas de la imagen
matMult
ldr r5,[r1],#1//extrae el dato en r1+4 de memoria
ldr r6,[r2],#1//extrae el dato en r2+4 de memoria
mul r7,r5,r6 //se multiplican los datos
add r8,r8,r7 //se almacena el dato para la suma de las multiplicaciones 
mov r7,#0//limpia r7
sub r9,r9,#1//se disminuye el contador
cmp r9,#0 //se evalua si se termino el proceso
bnq matMult
add r2,r2,#50
sub r10,r10,#1//se disminuye el contador
cmp r10,#0 //se evalua si se termino el proceso
bnq jumpLine
add r12,r12,#1
str r8,[r3],#1 //almacena el resultado de la suma
mov r8,#0//limpia r8
cmp r12,#49 
bne xMapping
cmp r14,#49
bne yMapping
