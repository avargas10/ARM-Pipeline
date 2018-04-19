			;		Estudiante: Santiago Vargas de Kruijf - 2013050807
			;		Ejercicio 1 - Tarea 1
			;		R0 = Este registro almacena la posicion en memoria de la lista
			;		R1 = Este registro almacena el valor del tamao de la lista
			;		R2 = Este registro almacena la posicion en memoria de la lista
			;		R3 = Este registro funciona como contador de la lista
			;		R4 = Este registro funciona como temporal para la copia del valor de destino
			;		R5 = Este registro funciona como prueba para verificar el valor copiado
list			DCD		21,17,9,10,11,9,1 ;lista a utilizar
list_count	DCD		7 ;tamao de la lista
list_dest		DCD		0,0,0,0,0,0,0,0,0,0  ;Inicializacion lista destino
		;-------------------INICIO	DEL ALGORITMO-----------------------
inicio
			ldr		R0, =list ;obtiene la posicin de memoria inicial de la lista source
			ldr		R1, =list_count ;obtiene la posicin de memoria en la cual se almacena el tamao de la lista source
			ldr		R1, [R1] ;guarda el tamao de la lista source en R1
			ldr		R2, =list_dest ; Cargo en R2 la posicion en memoria de la lista destino
loop
			cmp		R3, R1	; Comparo si ya el registro de conteo llego al tama�o de source
			beq		fin		; Salida del programa
			ldr		R4, [R0]  ; Cargar en R4 el valor de la direccion de R0
			cmp		R4, #1	; Si el valor cargado es 1 se corta la ejecucion
			beq		fin		; Salida del programa
			str		R4, [R2]	; Copio en la direccion de memoria R2 el valor R4
			ldr		R5, [R2]	; Copio en R5 para verificar que el valor si fue copiado
			add		R2, R2, #0x4 ; Hago que R2 pase a la siguiente posicion de la lista
			add		R0, R10, #0x4 ; Hago que R0 pase a la siguiente posicion de la lista
			add		R3, R3, #0x1 ;aumenta el contador
			b		loop			; Volvemos al loop
fin
			end		; Fin del programa
