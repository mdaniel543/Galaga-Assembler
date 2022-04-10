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
    ;====pinto el nivel 1=====
    Inicio_Nivel1

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

Inicio_Nivel1 MACRO
LOCAL e1, e2, e3, e5
    ; ===================== pinto la nave del centro====================
    mov nx, 202d
    mov ny, 190d

    PintarNave nx, ny, 15d
    pintar_nave_detalles nx, ny, 4d

    push bx
    push cx
    ;==============================cañon centro=====================
    xor bx, bx
    xor cx, cx
    
    mov bx, nx
    mov cx, ny

    mov cCenx, bx
    mov cCeny, cx

    add cCenx, 7
    sub cCeny, 12
    
    PintarCanon cCenx, cCeny

    pop cx
    pop bx
    ;===============================enemigos=========================
    
    mov contaux1, 10d ; suplantar el 10d cuando se mueva 
    mov oaux3, 0

    e5:
        inc oaux3

        mov contaux2, 115d
        mov contaux, 0
        
        e1:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 1d 
            add contaux2, 30
            cmp contaux, 7
        jne e1

        add contaux1, 16
        mov contaux2, 115d
        mov contaux, 0
        
        e2:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 2d 
            add contaux2, 30
            cmp contaux, 7
        jne e2

        add contaux1, 16
        mov contaux2, 115d
        mov contaux, 0
        
        e3:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 14d 
            add contaux2, 30
            cmp contaux, 7
        jne e3

        add contaux1, 16
        cmp oaux3, 1
    jne e5

ENDM


Inicio_Nivel2 MACRO
LOCAL e1, e2, e3, e5
     ;====================segunda nave de izquerda=============
    mov nx, 202d
    mov ny, 190d

    PintarNave nx, ny, 15d
    pintar_nave_detalles nx, ny, 4d

    push bx
    push cx
    ;==========================cañon izquierda=================
    mov bx, nx
    mov cx, ny

    mov cIzqx, bx
    mov cIzqy, cx 

    sub cIzqy, 3 

    PintarCanon cIzqx, cIzqy
     ;==============================cañon centro=====================
    mov cCenx, bx
    mov cCeny, cx

    add cCenx, 7
    sub cCeny, 12
    
    PintarCanon cCenx, cCeny

    pop cx
    pop bx
    ;=====================enemigos==============================


    mov contaux1, 10d ; suplantar el 10d cuando se mueva 
    mov oaux3, 0

    e5:
        inc oaux3

        mov contaux2, 115d
        mov contaux, 0
        
        e1:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 1d 
            add contaux2, 30
            cmp contaux, 7
        jne e1

        add contaux1, 16
        mov contaux2, 115d
        mov contaux, 0
        
        e2:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 2d 
            add contaux2, 30
            cmp contaux, 7
        jne e2

        add contaux1, 16
        mov contaux2, 115d
        mov contaux, 0
        
        e3:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 14d 
            add contaux2, 30
            cmp contaux, 7
        jne e3

        add contaux1, 16
        cmp oaux3, 2
    jne e5

ENDM


Inicio_Nivel3 MACRO
LOCAL e1, e2, e3, e5
    mov nx, 202d
    mov ny, 190d

    PintarNave nx, ny, 15d
    pintar_nave_detalles nx, ny, 4d

    push bx
    push cx
     ;==========================cañon izquierda=================
    mov bx, nx
    mov cx, ny

    mov cIzqx, bx
    mov cIzqy, cx 

    sub cIzqy, 3 

    PintarCanon cIzqx, cIzqy
     ;==============================cañon centro=====================
    mov cCenx, bx
    mov cCeny, cx

    add cCenx, 7
    sub cCeny, 12
    
    PintarCanon cCenx, cCeny
    ;======================cañon derecha===================
    mov cDerx, bx
    mov cDery, cx

    add cDerx, 14
    sub cDery, 3

    PintarCanon cDerx, cDery

    pop cx
    pop bx
    ; ======================enemigos================
    mov contaux1, 10d ; suplantar el 10d cuando se mueva 
    mov oaux3, 0

    e5:
        inc oaux3

        mov contaux2, 115d
        mov contaux, 0
        
        e1:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 1d 
            add contaux2, 30
            cmp contaux, 7
        jne e1

        add contaux1, 16
        mov contaux2, 115d
        mov contaux, 0
        
        e2:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 2d 
            add contaux2, 30
            cmp contaux, 7
        jne e2

        add contaux1, 16
        mov contaux2, 115d
        mov contaux, 0
        
        e3:
            inc contaux
            Dibujar_enemigo contaux2, contaux1, 14d 
            add contaux2, 30
            cmp contaux, 7
        jne e3

        add contaux1, 16
        cmp oaux3, 3
    jne e5


ENDM 

PintarNave MACRO x, abajo, color 
LOCAL e2, ciclo1, e1
    push si
    push cx

    xor cx, cx
    mov cx, abajo
    mov contador4, cx

    xor si, si
    mov si, x

    mov auxnave2, si

    mov auxnave, si
    add auxnave, 15

    mov contador3, 0
    mov contador5, 0

    e2:
        inc contador3
        e1:
            inc contador5
            mov si, auxnave2
            ciclo1:
                pintar_pixel contador4, si, color 
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

    pop cx
    pop si
ENDM

pintar_nave_detalles MACRO x, abajo, color
LOCAL 
    push si
    push cx
    ;==================puntos ROSJOS esquinas==========================
    xor si, si
    xor cx, cx
    
    mov si, x
    mov cx, abajo

    mov auxnave, si
    mov auxnave2, cx

    add auxnave, 3
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 

    dec auxnave2
    mov auxnave, si
    add auxnave, 3
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 

    dec auxnave2
    pintar_pixel auxnave2, auxnave, color 


    add auxnave, 3
    pintar_pixel auxnave2, auxnave, color 

    inc auxnave2
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 

    inc auxnave2
    mov auxnave, si
    add auxnave, 8
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 

    ;===================puntos rojos centro=================
    mov auxnave, si
    mov auxnave2, cx

    sub auxnave2, 4

    add auxnave, 5
    pintar_pixel auxnave2, auxnave, color 
    add auxnave, 3
    pintar_pixel auxnave2, auxnave, color 
    
    dec auxnave2 
    mov auxnave, si
    add auxnave, 5

    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 
    inc auxnave
    pintar_pixel auxnave2, auxnave, color 

    pop cx
    pop si
ENDM

PintarCanon MACRO x, abajo
LOCAL 
    push si
    push cx

    xor cx, cx 
    mov cx, abajo
    mov auxnave2, cx

    pintar_pixel auxnave2, x, 9d
    dec auxnave2
    pintar_pixel auxnave2, x, 7d 
    dec auxnave2
    pintar_pixel auxnave2, x, 7d
    dec auxnave2
    pintar_pixel auxnave2, x, 6d
    dec auxnave2
    
    pop cx
    pop si

ENDM

Dibujar_enemigo MACRO x, y, color
LOCAL e2, ciclo1, e1
    push si
    push cx

    xor cx, cx
    mov cx, y
    mov contador4, cx

    xor si, si
    mov si, x

    mov auxnave2, si

    mov auxnave, si
    add auxnave, 8

    mov contador3, 0
    mov contador5, 0

    e2:
        inc contador3
        e1:
            inc contador5
            mov si, auxnave2
            ciclo1:
                pintar_pixel contador4, si, color 
                inc si 
                cmp si, auxnave
            jne ciclo1
            inc contador4
            cmp contador5, 2
        jne e1

        mov contador5, 0

        add auxnave2, 1
        mov si, auxnave2

        sub auxnave, 1

        cmp contador3, 4
    jne e2

    xor cx, cx
    xor si, si
    
    mov cx, y
    mov oaux, cx
    mov si, x
    mov oaux2, si

    add oaux, 2

    add oaux2, 2
    pintar_pixel oaux, oaux2, 0d
    add oaux2, 1
    pintar_pixel oaux, oaux2, color
    add oaux2, 1
    pintar_pixel oaux, oaux2, color

    add oaux, 1
    mov oaux2, si

    add oaux2, 2
    pintar_pixel oaux, oaux2, 0d
    add oaux2, 1
    pintar_pixel oaux, oaux2, color
    add oaux2, 1
    pintar_pixel oaux, oaux2, color
    

    add oaux, 2
    mov oaux2, si
    add oaux2, 2
    pintar_pixel oaux, oaux2, color
    add oaux2, 2
    pintar_pixel oaux, oaux2, 0d
    add oaux2, 1
    pintar_pixel oaux, oaux2, color

    pop cx
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