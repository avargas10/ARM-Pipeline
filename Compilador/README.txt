---------------------------
Dependencias necesarias
.....Windows
	cygwin (gcc/g++)
	MinGW
	GnuWin32
.....Linux
	gcc/g++
lex/flex and yacc/bison

--------------------------
Compilacion
Windows: Desde la terminal de cygwin
	g++ lex.yy.c y.tab.c -std=gnu++11 -o compilador

Linux: Terminal
	g++ lex.yy.c y.tab.c -std=c++11 -o compilador


-------------------------
Ejecucion
Windows: Desde la terminal de cygwin
	./compilador
linux: ./compilador
	
Al ejecutar el programa este solicitara la ruta del archivo que desea compilador, al terminar la compilacion se generara un archivo text.txt (instrucciones) y data.txt (variables)