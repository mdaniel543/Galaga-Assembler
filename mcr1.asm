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

LimpiarArreglo MACRO arreglo
Local Ciclo
	xor si,si
	xor cx,cx
	mov cx, SIZEOF arreglo

	Ciclo:
	mov arreglo[si], 24h
	inc si
	loop Ciclo

ENDM


IniciarSesion MACRO 
Local iniuser, user, inipass
    iniuser:
        LimpiarArreglo buffer
        print msgUsername
        xor si, si
    user:
        getChar
        cmp al, 13
        je inipass 
        mov buffer[si], al
        inc si
        jmp user
    inipass:
        print buffer
        LimpiarArreglo buffer
        print msgPassword
        xor si, si
    pass:
        getChar
        cmp al, 13
        je sale 
        mov buffer[si], al
        inc si
        jmp pass
    sale:
        print buffer
        LimpiarArreglo buffer
ENDM

Registrarse MACRO



ENDM