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

getpass MACRO 
    mov ah, 07h	;No. 7 comando de interrupción, la entrada del teclado no tiene eco, AL = carácter de entrada
    int 21h
ENDM

aste MACRO
    mov ah,2		
    mov dl,'*'      
    int 21h
ENDM


Credenciales MACRO 
Local iniuser, user, inipass, pass, sale
    iniuser:
        LimpiarArreglo bufferU
        print msgUsername
        xor si, si
    user:
        getChar
        cmp al, 13
        je inipass 
        mov bufferU[si], al
        inc si
        jmp user
    inipass:
        ;print bufferU
        LimpiarArreglo bufferP
        print msgPassword
        xor si, si
    pass:
        getpass
        cmp al, 13
        je sale 
        mov bufferP[si], al
        aste
        inc si
        jmp pass
    sale:
        ;print bufferP
        print salto
ENDM


UserGal MACRO 
    LimpiarArreglo users
	AbrirArchivo ArchivoRutaUsuarios, ArchivoHandler
	LecturaUsuarios ArchivoHandler
	CerrarArchivo ArchivoHandler
ENDM


LecturaUsuarios MACRO handler
LOCAL
    mov ah, 3fh
	mov bx, handler
	mov cx, SIZEOF users
	lea dx, users
	int 21h
	jc Error
ENDM

ComprobarUsuario MACRO 
LOCAL Inicio, final, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11
    Inicio: 
    xor di, di
    u0:
        xor si, si
    u1:
        mov al, users[di]
        cmp al, 44
        je u2 ; comprobar pass 
        cmp al, bufferU[si]
        jne u4
        inc si 
        inc di
        jmp u1
    u2:
        xor si, si 
    u3:
        inc di
        mov al, users[di]
        cmp al, 44
        je u5 ; esta correcto
        cmp al, bufferP[si]
        jne u6
        inc si
        jmp u3
    u4:
        mov al, users[di]
        inc di
        cmp al, 13
        je u0 ; va a buscar otro usuario con el enter
        cmp al, 36
        je u7
        jmp u4
    u5:
        inc di 
        mov al, users[di]
        cmp al, 49 ; si el usuario esta bloqueado
        je u8
        inc di 
        inc di 
        mov al, users[di]
        cmp al, 48 ; si es usuario normal
        je u9
        cmp al, 49; si es admin 
        je u10
        cmp al, 50; si es admin general
        je u11
        jmp final
    u6:
        print msgPassError
        jmp final
    u7:
        print msgNoExisteUser
        jmp final
    u8:
        print msgUsuarioBloqueado
        jmp final
    u9: 
        print msgLoginCorrecto
        jmp final
    u10:
        print msgAdmin1
        jmp final
    u11:
        print msgAdminLogin
        jmp final 
    final:
        print salto
ENDM

EscribirUser MACRO 
    CrearArchivo ArchivoRutaUsuarios,ArchivoHandler
    Registrarse
    CerrarArchivo ArchivoHandler
    print salto 
ENDM 

EscribirArchivoF MACRO arreglo
Local Inicio,Final
	mov al, arreglo
	cmp al, 36
	je Final

	Inicio:
	mov ah, 40h
	mov bx, ArchivoHandler
	mov cx, 01h
	lea dx, arreglo
	int 21h
	jc Error	

	Final:
ENDM

Registrarse MACRO
LOCAL e0, e1, e2, e3, e4, e5, e6
    e0:
        xor si, si
        xor di, di 
    e1:
        mov al, users[si]
        cmp al, 36
        je e2
        EscribirArchivoF users[si]
        inc si
        jmp e1
    e2:
        mov al, bufferU[di]
        cmp al, 36
        je e3 ; escribir pass 
        mov users[si], al
        EscribirArchivoF users[si]
        inc si
        inc di 
        jmp e2
    e3:
        mov al, 44
        mov users[si], al    
        EscribirArchivoF users[si]
        inc si
        xor di, di
    e4:
        mov al, bufferP[di]
        cmp al, 36
        je e5 ; lo demas 
        mov users[si], al 
        EscribirArchivoF users[si]
        inc si
        inc di 
        jmp e4
    e5:
        mov al, 44
        mov users[si], al 
        EscribirArchivoF users[si]   
        inc si
        mov al, 48
        mov users[si], al
        EscribirArchivoF users[si]
        inc si
        mov al, 44
        mov users[si], al
        EscribirArchivoF users[si]    
        inc si
        mov al, 48
        mov users[si], al
        EscribirArchivoF users[si]    
        inc si
        mov al, 59
        mov users[si], al
        EscribirArchivoF users[si]
        inc si 
        mov al, 13
        mov users[si], al
        EscribirArchivoF users[si]
    e6:
    ;EscribirArchivo users, ArchivoHandler
ENDM