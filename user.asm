MenUsuario MACRO
LOCAL e1, e2, e3, e4, e5, e6, e7, e8, e9
    e1:
        print msgUsermenu
        print bufferU
        print salto
        print msgLine
        print msgOpcionesUser
        getTecla
        cmp ah, 3Ch; F2 Jugar
        je e2
        cmp ah, 3Dh; F3 top
        je e3
        cmp ah, 3Fh; F5 Top my
        je e4
        cmp ah, 43h; F9 Logut
        je e5
        jmp e1
    e2:
        EmpiezaJuego
        jmp e1
    e3:
        jmp e1
    e4:
        jmp e1
    e5:
        limpiar
        print msgCerrarSession
        print salto 
    e6:

ENDM 

EmpiezaJuego MACRO 
    limpiar
    ModoGrafico
    DatosMostrados
    ; filas 199, columnas 319
    pintar_linea 100d, 0d, 199d, 9d 

    FiguraCorazon 40d, 155d, 4d

    FiguraCorazon 60d, 155d, 4d

    FiguraCorazon 80d, 155d, 4d

    mov c1, 202d
    mov c2, 190d

    PintarNave c1, c2 

  

    Delay2 6000
    ModoTexto
ENDM

DatosMostrados MACRO 
    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 1d ;23 fil
	mov dl, 0d ;118 col
	int 10h
    call DS_DATOS ;Cambia de DS al lugar de las variables
	print msgjuego1
    call DS_VIDEO ;Cambio de DS a memoria de video

    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 3d ;23 fil
	mov dl, 0d ;118 col
	int 10h
    call DS_DATOS ;Cambia de DS al lugar de las variables
	print bufferU
    call DS_VIDEO ;Cambio de DS a memoria de video

    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 5d ;23 fil
	mov dl, 0d ;118 col
	int 10h
	call DS_DATOS ;Cambia de DS al lugar de las variables
	print msgjuego2
    call DS_VIDEO ;Cambio de DS a memoria de video

    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 7d ;23 fil
	mov dl, 8d ;118 col
	int 10h
	call DS_DATOS ;Cambia de DS al lugar de las variables
	Imprimir level
    call DS_VIDEO ;Cambio de DS a memoria de video

    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 9d ;23 fil
	mov dl, 0d ;118 col
	int 10h
	call DS_DATOS ;Cambia de DS al lugar de las variables
	print msgjuego3
    call DS_VIDEO ;Cambio de DS a memoria de video


    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 11d ;23 fil
	mov dl, 4d ;118 col
	int 10h
	call DS_DATOS ;Cambia de DS al lugar de las variables
	print score
    call DS_VIDEO ;Cambio de DS a memoria de video

    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 13d ;23 fil
	mov dl, 0d ;118 col
	int 10h
	call DS_DATOS ;Cambia de DS al lugar de las variables
	print msgjuego4
    call DS_VIDEO ;Cambio de DS a memoria de video

    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 15d ;23 fil
	mov dl, 2d ;118 col
	int 10h
	call DS_DATOS ;Cambia de DS al lugar de las variables
	print time
    call DS_VIDEO ;Cambio de DS a memoria de video

    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 17d ;23 fil
	mov dl, 0d ;118 col
	int 10h
	call DS_DATOS ;Cambia de DS al lugar de las variables
	print msgjuego5
    call DS_VIDEO ;Cambio de DS a memoria de video


ENDM

;METODOS DEL MODO GRAFICO
ModoTexto MACRO
	;Regresar a modo texto  
	mov ax,0003h    
	int 10h
	mov ax,@data
	mov ds,ax
ENDM

ModoGrafico MACRO
	;Iniciacion de modo video  
	mov ax,0013h ;nos da una resolución de 200x320 (pixeles (alto,ancho))
	int 10h
	mov ax, 0A000h
	mov ds, ax  ; DS = A000h (memoria de graficos).
ENDM

pintar_pixel MACRO i, j, color
    push ax
    push bx
    push di
    xor ax, ax
    xor bx, bx
    xor di, di
    mov ax, 320d
    mov bx, i
    mul bx
    add ax, j
    mov di, ax
    mov [di], color
    pop di
    pop bx
    pop ax
ENDM


pintar_linea MACRO izq, arr, aba, color
LOCAL ciclo1, ciclo2
    push si
    xor si, si
    mov si, arr
    ciclo2:
        pintar_pixel si, izq, color
        inc si
        cmp si, aba
    jne ciclo2
    pop si
ENDM


FiguraCorazon MACRO izq, arr, color 
LOCAL ciclo1, ciclo2, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, ciclo3, ciclo4, ciclo5
    push si 
    xor si, si 
 
    mov contador2, 0
    mov contador1, 0 
        
    mov auxcoro2, arr

    e1:
        inc contador1
        mov auxcora, izq
        mov si, izq
        mov contador2, 0
        e2:
            inc contador2
            
            add auxcora, 4

            ciclo1:
                pintar_pixel auxcoro2, si, color 
                inc si 
                cmp si, auxcora
            jne ciclo1
            
            add si, 2
            add auxcora, 2

            cmp contador2, 2
        jne e2
        
        inc auxcoro2
        cmp contador1, 2
    jne e1

    e3:
        mov contador1, 0
        mov auxcora, izq
        add auxcora, 12
    e4:
        inc contador1
        mov si, izq
        sub si, 2
        ciclo2:
            pintar_pixel auxcoro2, si, color 
            inc si 
            cmp si, auxcora
        jne ciclo2
        inc auxcoro2
        cmp contador1, 4
    jne e4

    e5:
        mov contador1, 0
        mov auxcora, izq
        add auxcora, 10
    e6:
        inc contador1
        mov si, izq
        ciclo3:
            pintar_pixel auxcoro2, si, color 
            inc si 
            cmp si, auxcora
        jne ciclo3
        inc auxcoro2
        cmp contador1, 2
    jne e6

    e7:
        mov contador1, 0
        mov auxcora, izq
        add auxcora, 8
    e8:
        inc contador1
        mov si, izq
        add si, 2
        ciclo4:
            pintar_pixel auxcoro2, si, color 
            inc si 
            cmp si, auxcora
        jne ciclo4
        inc auxcoro2
        cmp contador1, 2
    jne e8
   
    e9:
        mov contador1, 0
        mov auxcora, izq
        add auxcora, 6
    e10:
        inc contador1
        mov si, izq
        add si, 4
        ciclo5:
            pintar_pixel auxcoro2, si, color 
            inc si 
            cmp si, auxcora
        jne ciclo5
        inc auxcoro2
        cmp contador1, 2
    jne e10
    
    
    pop si
ENDM

PintarNave MACRO x, abajo
LOCAL e2, ciclo1, e1
    push si

    mov contador4, abajo

    xor si, si
    mov si, x
    mov auxnave2, x

    mov auxnave, x
    add auxnave, 15

    mov contador3, 0
    mov contador5, 0

    e2:
        inc contador3
        e1:
            inc contador5
            mov si, auxnave2
            ciclo1:
                pintar_pixel contador4, si, 15d 
                inc si 
                cmp si, auxnave
            jne ciclo1
            dec contador4
            cmp contador5, 3
        jne e1

        mov contador5, 0

        add auxnave2, 2
        mov si, auxnave2

        sub auxnave, 2

        cmp contador3, 4
    jne e2


    ;==================puntos ROSJOS esquinas==========================
    mov auxnave, x
    mov auxnave2, abajo

    add auxnave, 3
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 

    dec auxnave2
    mov auxnave, x
    add auxnave, 3
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 

    dec auxnave2
    pintar_pixel auxnave2, auxnave, 4d 


    add auxnave, 3
    pintar_pixel auxnave2, auxnave, 4d 

    inc auxnave2
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 

    inc auxnave2
    mov auxnave, x
    add auxnave, 8
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 

    ;===================puntos rojos centro=================
    mov auxnave, x
    mov auxnave2, abajo

    sub auxnave2, 4

    add auxnave, 6
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 
    
    dec auxnave2 
    mov auxnave, x
    add auxnave, 6

    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 
    inc auxnave
    pintar_pixel auxnave2, auxnave, 4d 
   
    pop si
ENDM

PintarCanon MACRO x, abajo
LOCAL 
    push si
    lea auxnave2, abajo

    pintar_pixel auxnave2, x, 9d
    dec auxnave2
    pintar_pixel auxnave2, x, 7d 
    dec auxnave2
    pintar_pixel auxnave2, x, 7d
    dec auxnave2
    pintar_pixel auxnave2, x, 6d
    dec auxnave2
    pop si
ENDM


delay MACRO param   
LOCAL ret1, ret2, finRet
    push ax
    push bx
    xor ax, ax
    xor bx, bx
    mov ax,param
    ret2:
        dec ax
        jz finRet
        mov bx, param
    ret1:
        dec bx
        jnz ret1
        jmp ret2                
    finRet:
        pop bx
        pop ax
ENDM 