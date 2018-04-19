		;		Estudiante: Santiago Vargas de Kruijf - 2013050807
		;		Ejercicio 1 - Tarea 1
		;		R0 = Este registro almacena la posicion en memoria de la lista
		;		R1 = Este registro almacena el valor del tamaño de la lista
		;		R2 = Este registro almacena la posicion en memoria de la lista
		;		R3 = Este registro funciona como contador de la lista
		;		R4 = Este registro funciona como temporal para la copia del valor de destino
		;		R5 = Este registro funciona como prueba para verificar el valor copiado
		
list_x	DCD		0, 63, 127, 255, 0, 63, 127, 255, 0, 63, 127, 255 ; Inicializacion x(n)
list_h	DCD		1, 0, 1  ; Inicializacion de h(n)
val_n	DCD		4 ; Valor de N buscado
		
		
		;-------------------INICIO	DEL ALGORITMO-----------------------
inicio
		ldr		R0, =list_x ;obtiene la posición de memoria inicial de x(n)
		ldr		R1, =list_h ; Cargo en R2 la posicion en memoria de la lista h(n)
		
		ldr		R2, =val_n ; Obtiene la direccion en memoria del valor n buscado
		ldr		R2, [R2] ; Obtiene el valor almacenado en la direccion de memoria
		
		mov		R5,  #0x0 ;Inicializo R5 para hacer el conteo de N con respecto a R0
		mov		R8, #0x0 ;Inicializo R8 para almacenar el resultado
		mov		R9, #0x0 ;Inicializo R9 para llevar el resultado de la multiplicacion
		
		b		ajustar
		
ajustar						; Se ajusta la posicion del registro R0 con el valor de N
		cmp		R5, R2		; Si ya alcance las N sumas me detengo y calculo
		beq		calculo
		
		add		R0, R0, #0x4 ; Paso a la siguiente posicion del arreglo
		add		R5, R5, #0x1	; Le sumo al contador
		b		ajustar
		
		
calculo
		
		;		Calculo de valor K0 = h(0)x(n+1)
		ldr		R3, [R1]	; h(0)
		add		R1, R1, #0x4 ; Paso a la posicion de memoria h(1) en el arreglo para el siguiente coeficiente
		mov		R6, R0	; Uso R6 como temporal para no modificar la posicion de la lista
		add		R6, R6, #0x4 ; Ajusto R6 y obtengo x(n+1)
		ldr		R6, [R6]	; Obtengo el valor de la direccion x(n+1)
		add		R8, R8, R6
		
calculo_2
		
		;		Calculo de valor K1 = h(1)x(n)
		ldr		R3, [R1]	; h(1)=0
		add		R1, R1, #0x4 ; Paso a la posicion de memoria h(2) en el arreglo para el siguiente coeficiente
		ldr		R6, [R0]	; Obtengo el valor de la direccion x(n)
		add		R8, R8, #0
		
calculo_3
		;		Calculo de valor K2 = h(2)x(n-1)
		ldr		R3, [R1]	; h(2)
		mov		R6, R0	; Uso R6 como temporal para no modificar la posicion de la lista
		sub		R6, R6, #0x4 ; Ajusto R6 y obtengo x(n-1)
		ldr		R6, [R6]	; Obtengo el valor de la direccion x(n+1)
		add		R8, R8, R6
		
		
		
		
		
		
fin
		end		; Finalizar ejecucion
		
		
		
		
