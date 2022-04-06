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


Credenciales MACRO principio
Local pord, iniuser, user, inipass, pass, sale
    pord:
        mov al, principio
        cmp al, 01h
        je inipass
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


ValidacionUsuario MACRO 
Local e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15, e16, e17, e18, e19, e20, e21, e22
    e1:
    xor si, si
    mov banderaU1, 00h
    mov banderaU2, 00h
    mov banderaU3, 00h
    mov banderaU4, 00h
    mov banderaP1, 00h
    mov banderaP2, 00h
    mov banderaP3, 00h
    mov banderaP4, 00h
    mov banderaG, 00h
    mov conteo, 0

    e2: ;primera validacion
        mov al, bufferU[si]
        cmp al, 48
        jae e3
        
        jmp e5
    e3:
        cmp al, 57
        jbe e4

        jmp e5
    e4:
        mov banderaU1, 01h
        mov banderaG, 01h
    e5:; segunda validacion
        mov al, bufferU[si]
        cmp al, 36
        je e6

        add conteo, 1 
        inc si 
        jmp e5

    e6:
        mov al, conteo
        cmp al, 8
        jae e7

        jmp e8

    e7: 
        cmp al, 15
        jbe e9

    e8:
        mov banderaU2, 01h
        mov banderaG, 01h
    e9:
        xor di, di
    e10:
        xor si, si
    e11:
        mov al, users[di]
        cmp al, 44
        je e15 ; ya existe
        cmp al, bufferU[si]
        jne e14
        inc si 
        inc di
        jmp e11
    e14:
        mov al, users[di]
        inc di
        cmp al, 13
        je e10 ; va a buscar otro usuario con el enter
        cmp al, 36
        je e16
        jmp e14
    
    e15:
        mov banderaU3, 01h
        mov banderaG, 01h
    e16: ;cuarta validacion
        xor si, si
    e17: 
        mov al, bufferU[si]

        cmp al, 36
        je e22

        inc si

        cmp al, 45 ;; -
        je e17
        cmp al, 46 ;; .
        je e17
        cmp al, 95 ;; _
        je e17
    
        cmp al, 97 ;; si es mayor que a 
        jae e18
        cmp al, 65 ;; si es mayor que A
        jae e19
        cmp al, 48 ;; si es mayor a 0
        jae e20
    
        jmp e21
    e18:
        cmp al, 122 ; si es menot que z
        jbe e17
        jmp e21
    e19:
        cmp al, 90 ;; si es mento que Z
        jbe e17
        jmp e21
    e20: 
        cmp al, 57 ;; menot que 9
        jbe e17
        jmp e21
    e21:
        mov banderaU4, 01h
        mov banderaG, 01h
    e22:
        ValidacionPass
ENDM



ValidacionPass MACRO
Local e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15, e16, e17, e18
    e1:
        xor si, si 
        mov conteo, 0
    e2: ;; VALIDACION 1 
        mov al, bufferP[si]
        inc si
        
        cmp al, 36 
        je e4

        cmp al, 48
        jae e3
        
        jmp e2
    e3:
        cmp al, 57
        jbe e5
        jmp e2
    e4:
        mov banderaP2, 01h 
        mov banderaG, 01h
    e5: ;; VALIDACION 2
        xor si, si 
    e6:
        mov al, bufferP[si]
        inc si
        
        cmp al, 36 
        je e8

        cmp al, 65
        jae e7
        
        jmp e6
    e7:
        cmp al, 90
        jbe e9
        jmp e6
    e8:
        mov banderaP1, 01h 
        mov banderaG, 01h
    e9: ;; VALIDACION 3
        xor si, si 
    e10:
        mov al, bufferP[si]
        inc si
        
        cmp al, 36 
        je e12

        cmp al, 33
        je e13
        cmp al, 62
        je e13
        cmp al, 37
        je e13
        cmp al, 59
        je e13
        cmp al, 42
        je e13
        
        jmp e10
    e12:
        mov banderaP3, 01h 
        mov banderaG, 01h
    e13: ;; VALIDACION 4
        xor si, si 
    e14:
        mov al, bufferP[si]
        
        cmp al, 36
        je e15

        add conteo, 1 
        inc si 
        jmp e14

    e15:
        mov al, conteo
        cmp al, 16
        jae e16

        jmp e17

    e16: 
        cmp al, 20
        jbe e18

    e17:
        mov banderaP4, 01h
        mov banderaG, 01h

    e18: 
        ImprimirValidaciones
ENDM


ImprimirValidaciones MACRO 
Local e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15, e16, e17, e18, e19, e20 
    e0:
        mov al, banderaG
        cmp al, 01h
        je eu
        jne e11
    eu:
        print msgValidaciones
        print msgValidacion
        print msgRequisito
    e1:
        mov al, banderaU1
        cmp al, 01h
        je e2
    e8:
        mov al, banderaU2
        cmp al, 01h
        je e3
    e9:
        mov al, banderaU3
        cmp al, 01h
        je e4
    e10:
        mov al, banderaU4
        cmp al, 01h
        je e5
    
    e12: 
        mov al, banderaP1
        cmp al, 01h
        je e16
    e13: 
        mov al, banderaP2
        cmp al, 01h
        je e17
    e14: 
        mov al, banderaP3
        cmp al, 01h
        je e18
    e15: 
        mov al, banderaP4
        cmp al, 01h
        je e19

        jmp e6
    e2:
        print msgVU1
        jmp e8 
    e3:
        print msgVU2
        jmp e9
    e4:
        print msgVU3
        jmp e10
    e5:
        print msgVU4
        jmp e12

    e16:
        print msgP1
        jmp e13
    e17:
        print msgP2
        jmp e14
    e18:
        print msgP3
        jmp e15
    e19:
        print msgP4
        jmp e6
    e6:
        print salto
        getChar
        jmp e20
    e11:
        EscribirUser
    e20:
ENDM 


ComprobarUsuario MACRO 
LOCAL Inicio, ur, final, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11
    Inicio: 
        xor di, di
        mov guardarDI, 0
        mov intentos, 0
    u0:
        xor si, si
    u1:
        mov al, users[di]
        cmp al, 44
        je ur ; comprobar pass 
        cmp al, bufferU[si]
        jne u4
        inc si 
        inc di
        jmp u1
    ur: 
        mov guardarDI, di 
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
        print salto
        add intentos, 1
        mov al, intentos

        mov di, guardarDI
        cmp al, 3
        je ure
        jmp u6c
    ure:
        inc di 
        mov al, users[di]
        mov temp, al
        inc di 
        mov al, users[di]
        cmp al, 59
        je eh

        jmp ure
    eh:
        mov al, temp
        cmp al, 48
        je normal
        jne admin
    admin:
        print msg3intentos
        print msgAdminPassE
        ;Contador30
        print msgAdminPassE2
        Delay2 7000
        jmp u6c
    normal:
        print msg3intentos
        mov di, guardarDI
    cloop:
        inc di
        mov al, users[di]
        cmp al, 44
        je cambiar
        jmp cloop
    cambiar:
        inc di
        mov users[di], 49
        ActualizarUsers
        jmp u8
    u6c:
        print msglogin
        print msgLine
        print msgUsername
        print bufferU
        print salto
        Credenciales 01h
        mov di, guardarDI
        jmp u2
    u7:
        print msgNoExisteUser
        getChar
        jmp final
    u8:
        print msgUsuarioBloqueado
        getChar
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

delay MACRO numero
LOCAL startD, endDelay
	mov cx, 1
	startD:
	cmp cx, numero
	je endDelay
	inc cx
	jmp startD
	endDelay:
ENDM

Delay2 macro constante
	LOCAL D1,D2,Fin_delay
	push si
	push di

	mov si,constante
	D1:
	dec si
	jz Fin_delay
	mov di,constante
	D2:
	dec di
	jnz D2
	jmp D1

	Fin_delay:
	pop di
	pop si
endm

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


ActualizarUsers MACRO
LOCAL e0, e1, e2
    e0:
        CrearArchivo ArchivoRutaUsuarios,ArchivoHandler
        xor si, si
    e1:
        mov al, users[si]
        cmp al, 36
        je e2
        EscribirArchivoF users[si]
        inc si
        jmp e1
    e2:
        CerrarArchivo ArchivoHandler
        print salto 
ENDM