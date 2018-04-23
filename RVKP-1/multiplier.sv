/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
module multiplier(Rs, Rm, result);
parameter N = 32;

//modulo de multiplicacion
output logic[N-1:0] result;

input logic[N-1:0] Rs; //Registro source
input logic[N-1:0] Rm; //Registro source 2
logic[N-1:0] res; //Registro destino
assign res = Rs*Rm;
assign result = ( res > 8'd255) ? 8'd255 : res; //Se truncan los valores que sobrepasan el valor maximo 255 (Maximo valor de pixel
                                                                                                            //escala de grises)

endmodule
