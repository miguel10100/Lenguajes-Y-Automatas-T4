;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID            
;LENGUAJES Y AUTOMATAS II - ISC 6 A
;ACTIVIDAD 2
;ELABORADO POR: TUN TUZ MIGUEL ANGEL
;FECHA DE ENTREGA: 13/05/2019.model small

.model small
.stack 64
.data
include 'emu8086.inc'
;Simples mensajes
msj1 db 0ah,0dh, 'Ingrese Tres Numeros del 0 al 9 : ', '$'
msj2 db 0ah,0dh, 'Primer Numero: ', '$'
msj3 db 0ah,0dh, 'Segundo Numero: ', '$'
msj4 db 0ah,0dh, 'Tercer Numero: ', '$'
Mayor db 0ah,0dh, 'El Numero Mayor Es: ', '$'

Digito1 db 100 dup('$')
Digito2 db 100 dup('$')
Digito3 db 100 dup('$') 

salto db 13,10,'',13,10,'$' ;salto de linea

.code
    inicio:
    
    mov si,0
    mov ax,@data
    mov ds,ax
    mov ah,09
    mov dx,offset msj1 ;Imprimimos el msj1
    int 21h                                  
    
;*******************Llamadas**********************************    

    call linea;llamamos el metodo saltodelinea.

    call numero ;

    mov Digito1,al ;lo guarda al digito1

    call linea

    call numero

    mov Digito2,al ;lo guarda al digito1

    call linea

    call numero

    mov Digito3,al ;lo guarda al digito1

    call linea 

;********procedimientos********

mov ah,digito1
mov al,digito2
cmp ah,al ;compara primero con el segundo
ja compara-1-3 ;si es mayor el primero, ahora lo compara con el tercero
jmp compara-2-3 ;si el primero no es mayor,ahora compara el 2 y 3 digito
compara-1-3:
mov al,digito3 ;ah=primer digito, al=tercer digito
cmp ah,al ;compara primero con tercero
ja mayor1 ;si es mayor que el tercero, entonces el primero es mayor que los 3

compara-2-3:
mov ah,digito2
mov al,digito3
cmp ah,al ;compara 2 y 3, YA NO es necesario compararlo con el 1,porque ya sabemos que el 1 no es mayor que el 2
ja mayor2 ;Si es mayor el 2,nos vamos al metodo para imprimirlo
jmp mayor3 ;Si el 2 no es mayor, obvio el 3 es el mayor                                                           

mayor1:

call MensajeMayor ;llama al metodo que dice: El digito mayor es:

mov dx, offset Digito1 ;Imprir El Digito 1 es mayor
mov ah, 9
int 21h
jmp exit

mayor2:
call MensajeMayor

mov dx, offset Digito2 ;Salto de linea
mov ah, 9
int 21h
jmp exit

mayor3:
call MensajeMayor

mov dx, offset Digito3 ;Salto de linea
mov ah, 9
int 21h
jmp exit

;**********************Metodos******************************

MensajeMayor:
mov dx, offset Mayor ;El digito Mayor es:
mov ah, 9
int 21h

ret
numero:
mov ah,01h; pedimos primer digito
int 21h
ret

linea:
mov dx, offset salto ;Salto de linea
mov ah, 9
int 21h
ret

exit:
mov ax, 4c00h
int 21h ;para termianr el programa
ends