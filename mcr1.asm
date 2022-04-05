limpiar MACRO 
    mov ah, 0fh
    int 10h
    mov ah, 0h
    int 10h
ENDM

print MACRO cadena
    MOV ax,@data
    MOV ds,ax
    MOV ah,09h
    MOV dx,offset cadena
    int 21h
ENDM

getChar MACRO
    mov ah,01h
    int 21h
ENDM

getTecla MACRO
	mov ah,00H
	int 16H
ENDM

Imprimir MACRO dato 
	mov al, dato
	mov var, al
	print var
ENDM
