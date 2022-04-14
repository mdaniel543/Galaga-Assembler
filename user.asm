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
        mov banderaTerminaJuego, 00h
        call EmpiezaJuego_proc
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
LOCAL e1, e2, e3 
    limpiar

    mov score[0], 48
    mov score[1], 48
    mov score[2], 48

    mov time[7], 48
    mov time[6], 48
    mov time[4], 48
    mov time[3], 48
    mov time[1], 48
    mov time[0], 48

    mov lives, 3

    mov level, 49

    ModoGrafico

    call DatosMostrados_proc
    ; filas 199, columnas 319
    pintar_linea 100d, 0d, 199d, 9d 

    Call DS_DATOS

    FiguraCorazon 40d, 155d, 4d

    FiguraCorazon 60d, 155d, 4d

    FiguraCorazon 80d, 155d, 4d
    ;====pinto el nivel 1=====
    LLenarArreglo enemigos_nivel1, 49
    LLenarArreglo balas, 48d
    Llenar_Posicion1 posicion_enemigos1

    call Inicio_Nivel1_proc

    e1:
        getChar
        cmp al, 27
        je e3
        cmp al, 32
        je e2
    jmp e1

    e2:
        ImprimirPantalla 22d, 0d, limpia1

        ImprimirPantalla 22d, 0d, msg_esc1

        call Inicia_Juego
    e3:
    ModoTexto
ENDM

ImprimirPantalla MACRO  fila, columna, cadena 
    push ax
        call DS_VIDEO ;Cambio de DS a memoria de video
        xor ax, ax
	    mov ah, 02h
	    mov bh, 00h
	    mov dh, fila ;23 fil
	    mov dl, columna ;118 col
	    int 10h
	    call DS_DATOS 
        print cadena
    pop ax
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
	mov dl, 7d ;118 col
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

    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, 22d ;23 fil
	mov dl, 0d ;118 col
	int 10h
	call DS_DATOS ;Cambia de DS al lugar de las variables
	print msg_start1
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
    call DS_VIDEO
    mov [di], color
    pop di
    pop bx
    pop ax
    call DS_DATOS
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
    push si 
    xor si, si 
    mov si, 0
    ciclo1: 
        pintar_pixel 170d, si, color 
        inc si
        cmp si, izq
    jne ciclo1
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

Inicio_Tiempo MACRO 
LOCAL e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, level1, level2, l, level3
    e1:
        cmp banderaTerminaJuego, 01h
        je e10

        delay 150

        mov al, time[7]

        cmp al, 57
        je e5

        add al, 1
        mov time[7], al
        jmp e2

        e5:
            mov time[7], 48
            
            mov al, time[6]
            add al, 1
            mov time[6], al
            
            cmp al, 57
            je e3
        e2:
        ImprimirPantalla 15d, 2d, time
        
        cmp level, 49
        je level1
        cmp level, 50
        je level2
        cmp level, 51
        je level3
        level1:
            Bajar_Enemigos enemigos_nivel1, posicion_enemigos1, 250
            subir_balas enemigos_nivel1, posicion_enemigos1
            jmp l
        level2:
            Bajar_Enemigos enemigos_nivel2, posicion_enemigos2, 175
            subir_balas enemigos_nivel2, posicion_enemigos2
            jmp l
        level3:
            Bajar_Enemigos enemigos_nivel3, posicion_enemigos3, 100
            subir_balas enemigos_nivel3, posicion_enemigos3
            jmp l
        l:
        call mover_proc
    jmp e1

    e3:
        delay 100

        mov time[7], 48
        mov time[6], 48

        mov al, time[4]

        cmp al, 57
        je e7

        add al, 1
        mov time[4], al
        jmp e4

        e7:
            mov time[4], 48
            
            mov al, time[3]
            add al, 1
            mov time[3], al
            
            cmp al, 57
            je e6   
        e4:
        
        ImprimirPantalla 15d, 2d, time

    jmp e1

    e6:
        delay 100

        mov time[4], 48
        mov time[3], 48

        mov al, time[1]

        cmp al, 57
        je e9

        add al, 1
        mov time[1], al
        jmp e8

        e9:
            mov time[1], 48
            
            mov al, time[0]
            add al, 1
            mov time[0], al
            
            cmp al, 57
            je e10  
        e8:
        
        ImprimirPantalla 15d, 2d, time

    jmp e1

    e10:
ENDM

Mover MACRO 
LOCAL Izquierda, Derecha,level1,level12, level22,level3, level32, disparo2, level2, l,l2, sigue, Pausa, pe, lev, cambialetras, disparo1
	mov ah,01h
	int 16h
	cmp al,97
	je Izquierda
	cmp al,100
	je Derecha
    cmp al, 27
    je Pausa
    cmp al, 118; v
    je disparo1
    cmp al, 98; b
    je disparo2
    cmp al, 110
    je disparo3; n
    cmp al, 32
    je alldisparos; barra
    jmp sigue
    Izquierda:
        cmp level, 49
        je level1
        cmp level, 50
        je level2
        cmp level, 51
        je level3
        level1:
            Movimiento_Nivel1 00h
            jmp l
        level2:
            Movimiento_Nivel2 00h
            jmp l
        level3:
            Movimiento_Nivel3 00h
            jmp l
        l:
        mov ah, 00h
        int 16h
        jmp sigue
    Derecha:    
        cmp level, 49
        je level12
        cmp level, 50
        je level22
        cmp level, 51
        je level32
        level12:
            Movimiento_Nivel1 01h
            jmp l2
        level22:
            Movimiento_Nivel2 01h
            jmp l2
        level32:
            Movimiento_Nivel3 01h
            jmp l2
        l2:
        mov ah, 00h
        int 16h
        jmp sigue
    disparo1:
        Canon1_disparo
        mov ah, 00h
        int 16h
        jmp sigue 
    disparo2:
        Canon2_disparo
        mov ah, 00h
        int 16h
        jmp sigue 
    disparo3:
        Canon3_disparo
        mov ah, 00h
        int 16h
        jmp sigue 
    alldisparos
        Canon1_disparo
        Canon2_disparo
        Canon3_disparo
        mov ah, 00h
        int 16h
        jmp sigue 
    Pausa:
        mov ah, 00h
        int 16h
        ImprimirPantalla 22d, 0d, limpia1
        ImprimirPantalla 22d, 0d, msg_start2
        ImprimirPantalla 23d, 0d, msg_esc2
    pe:
        mov ah, 00h
	    int 16h
        cmp al, 32 
        je cambialetras
        cmp al, 27
        je lev
    jne pe
    lev: 
        mov banderaTerminaJuego, 01h
        jmp sigue
    cambialetras:
        ImprimirPantalla 22d, 0d, limpia1
        ImprimirPantalla 22d, 0d, msg_esc1
        ImprimirPantalla 23d, 0d, limpia1
    sigue:
    
ENDM

Movimiento_Nivel1 MACRO direccion
LOCAL i, d, m, c1, c2, f, c3
    mov al, direccion
    cmp al, 01
    je c1 
    c2:
        cmp nx, 101d
        je f
    jmp c3
    c1: 
        cmp nx, 303d
        je f
    jmp c3

    c3: 
    PintarNave nx, ny, 0d
    pintar_nave_detalles nx, ny, 0d

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
    
    PintarCanon cCenx, cCeny, 01h

    pop cx
    pop bx
    
    mov al, direccion
    cmp al, 01h
    je d
    i:
        sub nx, 1
        jmp m
    d:
        add nx, 1
    m:
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
        
        PintarCanon cCenx, cCeny, 00h

        pop cx
        pop bx
    f:
ENDM

Movimiento_Nivel2 MACRO direccion
LOCAL i, d, m, c1, c2, f, c3
    mov al, direccion
    cmp al, 01
    je c1 
    c2:
        cmp nx, 101d
        je f
    jmp c3
    c1: 
        cmp nx, 303d
        je f
    jmp c3

    c3: 
    PintarNave nx, ny, 0d
    pintar_nave_detalles nx, ny, 0d

    push bx
    push cx
    ;==========================cañon izquierda=================
    mov bx, nx
    mov cx, ny

    mov cIzqx, bx
    mov cIzqy, cx 

    sub cIzqy, 3 

    PintarCanon cIzqx, cIzqy, 01h
     ;==============================cañon centro=====================
    mov cCenx, bx
    mov cCeny, cx

    add cCenx, 7
    sub cCeny, 12
    
    PintarCanon cCenx, cCeny, 01h

    pop cx
    pop bx
    
    mov al, direccion
    cmp al, 01h
    je d
    i:
        sub nx, 1
        jmp m
    d:
        add nx, 1
    m:
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

        PintarCanon cIzqx, cIzqy, 00h
        ;==============================cañon centro=====================
        mov cCenx, bx
        mov cCeny, cx

        add cCenx, 7
        sub cCeny, 12
        
        PintarCanon cCenx, cCeny, 00h

        pop cx
        pop bx
    f:
ENDM


Movimiento_Nivel3 MACRO direccion
LOCAL i, d, m, c1, c2, f, c3
    mov al, direccion
    cmp al, 01
    je c1 
    c2:
        cmp nx, 101d
        je f
    jmp c3
    c1: 
        cmp nx, 303d
        je f
    jmp c3

    c3:
    PintarNave nx, ny, 0d
    pintar_nave_detalles nx, ny, 0d

    push bx
    push cx
     ;==========================cañon izquierda=================
    mov bx, nx
    mov cx, ny

    mov cIzqx, bx
    mov cIzqy, cx 

    sub cIzqy, 3 

    PintarCanon cIzqx, cIzqy, 01h
     ;==============================cañon centro=====================
    mov cCenx, bx
    mov cCeny, cx

    add cCenx, 7
    sub cCeny, 12
    
    PintarCanon cCenx, cCeny, 01h
    ;======================cañon derecha===================
    mov cDerx, bx
    mov cDery, cx

    add cDerx, 14
    sub cDery, 3

    PintarCanon cDerx, cDery, 01h

    pop cx
    pop bx

    mov al, direccion
    cmp al, 01h
    je d
    i:
        sub nx, 1
        jmp m
    d:
        add nx, 1
    m:
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

        PintarCanon cIzqx, cIzqy, 00h
        ;==============================cañon centro=====================
        mov cCenx, bx
        mov cCeny, cx

        add cCenx, 7
        sub cCeny, 12
        
        PintarCanon cCenx, cCeny, 00h
        ;======================cañon derecha===================
        mov cDerx, bx
        mov cDery, cx

        add cDerx, 14
        sub cDery, 3

        PintarCanon cDerx, cDery, 00h

        pop cx
        pop bx
    f:
ENDM

Canon1_disparo MACRO 
LOCAL e1, e2, e3, e4
    push ax
    xor ax, ax

    mov al, balas[0]
    cmp al, 49d
    je e3

    mov balas[0], 49d
    
    xor ax, ax
    
    sub cCeny, 5
    mov ax, cCeny
    mov balas[1], al
    mov suplente, ax
    
    Dibujar_Bala cCenx, suplente, 7d

    mov ax, cCenx
    
    mov ab, ax
    sub ab, 100d
    mov ax, ab
    mov balas[2], al
    
    e3:
    pop ax
ENDM

Canon2_disparo MACRO 
LOCAL e1, e2, e3, e4
    push ax
    xor ax, ax

    mov al, balas[3]
    cmp al, 49d
    je e3

    cmp level, 50
    jb e3

    mov balas[3], 49d
    
    xor ax, ax
    
    sub cIzqy, 5
    mov ax, cIzqy
    mov balas[4], al
    mov suplente, ax
    
    Dibujar_Bala cIzqx, suplente, 5d

    mov ax, cIzqx
    
    mov ab, ax
    sub ab, 100d
    mov ax, ab
    mov balas[5], al
    
    e3:
    pop ax
ENDM

Canon3_disparo MACRO 
LOCAL e1, e2, e3, e4
    push ax
    xor ax, ax

    mov al, balas[6]
    cmp al, 49d
    je e3

    cmp level, 51
    jb e3

    mov balas[6], 49d
    
    xor ax, ax
    
    sub cDery, 5
    mov ax, cDery
    mov balas[7], al
    mov suplente, ax
    
    Dibujar_Bala cDerx, suplente, 4d

    mov ax, cDerx
    
    mov ab, ax
    sub ab, 100d
    mov ax, ab
    mov balas[8], al
    
    e3:
    pop ax
ENDM


subir_balas MACRO enemigos, posicion
LOCAL e1, e2, e3, e4
    push bx 
    push ax
    push si
    xor ax, ax
    xor bx, bx
    xor si, si

    mov al, balas[0]
    cmp al, 49
    je e1
    mov al, balas[3]
    cmp al, 49
    je e2
    mov al, balas[6]
    cmp al, 49
    je e3

    jmp e4
    e1:
        bala_griss enemigos, posicion
        mov al, balas[3]
        cmp al, 49
        je e2
        mov al, balas[6]
        cmp al, 49
        je e3
    jmp e4
    ;=====================bala morada=====================
    e2:
        bala_morada enemigos, posicion
        mov al, balas[6]
        cmp al, 49
        je e3
    jmp e4
    ;===================bala roja===========================
    e3:
        bala_roja enemigos, posicion
        jmp e4
    e4:
    pop si
    pop ax
    pop bx
ENDM

bala_griss MACRO enemigos, posicion
LOCAL esc0, e11, e111, ciclo1,suma, esc1, esc2, ler, lee, sc1, scr1, scr2, scr4, rango, nocolison, elimino, dibujo_eliminacion, ociclo1, validar, f1, f2, f3, s1, s2,f4,f5,f6,f7,f8,f9
    push bx 
    push ax
    push si
    xor ax, ax
    xor bx, bx
    xor si, si

    mov al, balas[1]
    cmp al, 3
    je e11
    
    mov bl, balas[2]

    mov auxbala1, bx
    add auxbala1, 100

    mov auxbala2, ax
    
    Dibujar_Bala  auxbala1, auxbala2, 0d

    sub auxbala2, 1

    mov ax, auxbala2
    mov auxcolision2, ax 
    sub auxcolision2, 8

    mov auxcolision, ax

    xor bx, bx
    mov siaux, 0

    ;====compruebo si la nueva posicion colisona =======
    delay 75
    ciclo1:
        mov bl, posicion[si]
        cmp bl, 36
        je nocolison
        cmp auxcolision2, bx
        ja sc1	
        cmp auxcolision, bx
        jae validar
        sc1:
        inc si 
        inc si 
        inc siaux 
    jmp ciclo1
    ;=============hago validaciones de la colision===========
    validar:
        push siaux

        mov al, enemigos[si]
        cmp al, 48
        je ociclo1
        
        mov cote1, 0
        mov cote2, 0

        cmp siaux, 7
        jb dibujo_eliminacion
        cmp siaux, 14
        jb f2
        cmp siaux, 21
        jb f3
        cmp siaux, 28
        jb f4
        cmp siaux, 35
        jb f5
        cmp siaux, 42
        jb f6
        cmp siaux, 49
        jb f7
        cmp siaux, 56
        jb f8
        cmp siaux, 63
        jb f9
        f2: 
            sub siaux, 7
            jmp dibujo_eliminacion
        f3: 
            sub siaux, 14     
            jmp dibujo_eliminacion
        f4: 
            sub siaux, 21
            jmp dibujo_eliminacion
        f5: 
            sub siaux, 28     
            jmp dibujo_eliminacion
        f6: 
            sub siaux, 35
            jmp dibujo_eliminacion
        f7: 
            sub siaux, 42    
            jmp dibujo_eliminacion
        f8: 
            sub siaux, 49
            jmp dibujo_eliminacion
        f9: 
            sub siaux, 56
            jmp dibujo_eliminacion

        ;=============veo de que enemigo se trata=============
        dibujo_eliminacion:
            inc siaux
            mov al, 30d
            mul siaux
            mov cote2, ax
            add cote2, 85d 

            mov bx, cote2
            cmp auxbala1, bx
            jb ociclo1

            mov cote1, bx
            add cote1, 8
            mov bx, cote1 

            cmp auxbala1, bx
            ja ociclo1
            ;=====el enemigo ya localizado comprabamos su vida======
            inc si
            mov al, posicion[si]
            cmp al, 1
            je s2
            sub al, 1
            mov posicion[si], al  
            jmp s1
            s2:
            dec si 
            ;=======================================================
            mov al,  posicion[si]
            mov contaux1, ax

            Dibujar_enemigo cote2, contaux1, 0d
            mov enemigos[si], 48

            pop siaux
            push ax
            cmp siaux, 56
            jae esc2
            cmp siaux, 49
            jae esc1
            cmp siaux, 42
            jae esc0
            cmp siaux, 35
            jae esc2    
            cmp siaux, 28
            jae esc1
            cmp siaux, 21
            jae esc0
            cmp siaux, 14
            jae esc2
            cmp siaux, 7
            jae esc1
        
        esc0:
            mov decsuma, 1
            jmp suma

        esc1:
            mov decsuma, 2
            jmp suma
        esc2:
            mov decsuma, 3
            jmp suma

        suma:
            mov al, score[2]
            cmp al, 57
            je scr1
            add al, 1
            mov score[2], al
            jmp scr4
            scr1:
            mov score[2], 48
            mov al, score[1]
            cmp al, 57
            je scr2
            add al, 1
            mov score[1], al
            jmp scr4
            scr2:
            mov score[1], 48
            mov al, score[0]
            add al, 1
            mov score[0], al
        scr4:
            sub decsuma, 1
            cmp decsuma, 0
        ja suma
            pop ax
            call DS_VIDEO ;Cambio de DS a memoria de video
            xor ax, ax
            mov ah, 02h
            mov bh, 00h
            mov dh, 11d ;23 fil
            mov dl, 7d ;118 col
            int 10h
            call DS_DATOS ;Cambia de DS al lugar de las variables
            print score

            mov balas[0], 48
        jmp e111
        s1:
            mov balas[0], 48
            pop siaux
        jmp e111

        ociclo1:
            pop siaux
            inc si
            inc si
            inc siaux
        jmp ciclo1
    ;============sigo normal con la subida de la bala
    nocolison:
        Dibujar_Bala auxbala1, auxbala2, 7d

        mov ax, auxbala2
        mov balas[1], al

    jmp e111
    e11:
        mov balas[0], 48

        mov bl, balas[2]

        mov auxbala1, bx
        add auxbala1, 100

        mov auxbala2, ax
    
        Dibujar_Bala  auxbala1, auxbala2, 0d
    e111:

    pop si
    pop ax
    pop bx
ENDM

bala_morada MACRO enemigos, posicion
LOCAL esc0, e4, e11, e111, ciclo1,suma, esc1,ler, lee, esc2, sc1, scr1, scr2, scr4, rango, nocolison, elimino, dibujo_eliminacion, ociclo1, validar, f1, f2, f3, s1, s2, f4,f5,f6,f7,f8,f9
    push bx 
    push ax
    push si
    xor ax, ax
    xor bx, bx
    xor si, si
    ;============borro bala morada=============
    mov al, balas[4]
    cmp al, 3
    je e11
    
    mov bl, balas[5]

    mov auxbala1, bx
    add auxbala1, 100

    mov auxbala2, ax
    
    Dibujar_Bala  auxbala1, auxbala2, 0d

    sub auxbala2, 1

    mov ax, auxbala2
    mov auxcolision2, ax 
    sub auxcolision2, 8

    mov auxcolision, ax

    xor bx, bx
    mov siaux, 0

    ;====compruebo si la nueva posicion colisona =======
    delay 75
    ciclo1:
        mov bl, posicion[si]
        cmp bl, 36
        je nocolison
        cmp auxcolision2, bx
        ja sc1	
        cmp auxcolision, bx
        jae validar
        sc1:
        lee:
        inc si 
        inc si 
        inc siaux 
    jmp ciclo1
    ;=============hago validaciones de la colision===========
    validar:
        push siaux

        mov al, enemigos[si]
        cmp al, 48
        je ociclo1
        
        mov cote1, 0
        mov cote2, 0

        cmp siaux, 7
        jb dibujo_eliminacion
        cmp siaux, 14
        jb f2
        cmp siaux, 21
        jb f3
        cmp siaux, 28
        jb f4
        cmp siaux, 35
        jb f5
        cmp siaux, 42
        jb f6
        cmp siaux, 49
        jb f7
        cmp siaux, 56
        jb f8
        cmp siaux, 63
        jb f9
        f2: 
            sub siaux, 7
            jmp dibujo_eliminacion
        f3: 
            sub siaux, 14     
            jmp dibujo_eliminacion
        f4: 
            sub siaux, 21
            jmp dibujo_eliminacion
        f5: 
            sub siaux, 28     
            jmp dibujo_eliminacion
        f6: 
            sub siaux, 35
            jmp dibujo_eliminacion
        f7: 
            sub siaux, 42    
            jmp dibujo_eliminacion
        f8: 
            sub siaux, 49
            jmp dibujo_eliminacion
        f9: 
            sub siaux, 56
            jmp dibujo_eliminacion
        ;=============veo de que enemigo se trata=============
        dibujo_eliminacion:
            inc siaux
            mov al, 30d
            mul siaux
            mov cote2, ax
            add cote2, 85d 

            mov bx, cote2
            cmp auxbala1, bx
            jb ociclo1

            mov cote1, bx
            add cote1, 8
            mov bx, cote1 

            cmp auxbala1, bx
            ja ociclo1
            ;=====el enemigo ya localizado comprabamos su vida======
            inc si
            mov al, posicion[si]
            cmp al, 2
            jbe s2
            sub al, 2
            mov posicion[si], al  
            jmp s1
            s2:
            dec si 
            ;=======================================================
            mov al,  posicion[si]
            mov contaux1, ax

            Dibujar_enemigo cote2, contaux1, 0d
            mov enemigos[si], 48

            pop siaux
            push ax
            cmp siaux, 56
            jae esc2
            cmp siaux, 49
            jae esc1
            cmp siaux, 42
            jae esc0
            cmp siaux, 35
            jae esc2    
            cmp siaux, 28
            jae esc1
            cmp siaux, 21
            jae esc0
            cmp siaux, 14
            jae esc2
            cmp siaux, 7
            jae esc1
        
        esc0:
            mov decsuma, 1
            jmp suma

        esc1:
            mov decsuma, 2
            jmp suma
        esc2:
            mov decsuma, 3
            jmp suma

       suma:
            mov al, score[2]
            cmp al, 57
            je scr1
            add al, 1
            mov score[2], al
            jmp scr4
            scr1:
            mov score[2], 48
            mov al, score[1]
            cmp al, 57
            je scr2
            add al, 1
            mov score[1], al
            jmp scr4
            scr2:
            mov score[1], 48
            mov al, score[0]
            add al, 1
            mov score[0], al
        scr4:
            sub decsuma, 1
            cmp decsuma, 0
        ja suma
            pop ax
            call DS_VIDEO ;Cambio de DS a memoria de video
            xor ax, ax
            mov ah, 02h
            mov bh, 00h
            mov dh, 11d ;23 fil
            mov dl, 7d ;118 col
            int 10h
            call DS_DATOS ;Cambia de DS al lugar de las variables
            print score

            mov balas[3], 48
        jmp e111
        s1:
            mov balas[3], 48
            pop siaux
        jmp e111

        ociclo1:
            pop siaux
            inc si
            inc si
            inc siaux
        jmp ciclo1
    ;============sigo normal con la subida de la bala
    nocolison:
        Dibujar_Bala auxbala1, auxbala2, 5d

        mov ax, auxbala2
        mov balas[4], al
    jmp e111
    e11:
        mov balas[3], 48

        mov bl, balas[5]

        mov auxbala1, bx
        add auxbala1, 100

        mov auxbala2, ax
    
        Dibujar_Bala  auxbala1, auxbala2, 0d
    e111:
    pop si
    pop ax
    pop bx
ENDM

bala_roja MACRO enemigos, posicion
LOCAL esc0, e4, e11, e111, ciclo1,suma, esc1,ler, lee, esc2, sc1, scr1, scr2, scr4, rango, nocolison, elimino, dibujo_eliminacion, ociclo1, validar, f1, f2, f3, s1, s2, f4,f5,f6,f7,f8,f9
    push bx 
    push ax
    push si
    xor ax, ax
    xor bx, bx
    xor si, si
    ;============borro bala morada=============
    mov al, balas[7]
    cmp al, 3
    je e11
    
    mov bl, balas[8]

    mov auxbala1, bx
    add auxbala1, 100

    mov auxbala2, ax
    
    Dibujar_Bala  auxbala1, auxbala2, 0d

    sub auxbala2, 1

    mov ax, auxbala2
    mov auxcolision2, ax 
    sub auxcolision2, 8

    mov auxcolision, ax

    xor bx, bx
    mov siaux, 0

    ;====compruebo si la nueva posicion colisona =======
    delay 75
    ciclo1:
        mov bl, posicion[si]
        cmp bl, 36
        je nocolison
        cmp auxcolision2, bx
        ja sc1	
        cmp auxcolision, bx
        jae validar
        sc1:
        lee:
        inc si 
        inc si 
        inc siaux 
    jmp ciclo1
    ;=============hago validaciones de la colision===========
    validar:
        push siaux

        mov al, enemigos[si]
        cmp al, 48
        je ociclo1
        
        mov cote1, 0
        mov cote2, 0

        cmp siaux, 7
        jb dibujo_eliminacion
        cmp siaux, 14
        jb f2
        cmp siaux, 21
        jb f3
        cmp siaux, 28
        jb f4
        cmp siaux, 35
        jb f5
        cmp siaux, 42
        jb f6
        cmp siaux, 49
        jb f7
        cmp siaux, 56
        jb f8
        cmp siaux, 63
        jb f9
        f2: 
            sub siaux, 7
            jmp dibujo_eliminacion
        f3: 
            sub siaux, 14     
            jmp dibujo_eliminacion
        f4: 
            sub siaux, 21
            jmp dibujo_eliminacion
        f5: 
            sub siaux, 28     
            jmp dibujo_eliminacion
        f6: 
            sub siaux, 35
            jmp dibujo_eliminacion
        f7: 
            sub siaux, 42    
            jmp dibujo_eliminacion
        f8: 
            sub siaux, 49
            jmp dibujo_eliminacion
        f9: 
            sub siaux, 56
            jmp dibujo_eliminacion
        ;=============veo de que enemigo se trata=============
        dibujo_eliminacion:
            inc siaux
            mov al, 30d
            mul siaux
            mov cote2, ax
            add cote2, 85d 

            mov bx, cote2
            cmp auxbala1, bx
            jb ociclo1

            mov cote1, bx
            add cote1, 8
            mov bx, cote1 

            cmp auxbala1, bx
            ja ociclo1
            ;=====el enemigo ya localizado comprabamos su vida======
            inc si
            mov al, posicion[si]
            cmp al, 3
            jbe s2
            sub al, 3
            mov posicion[si], al  
            jmp s1
            s2:
            dec si 
            ;=======================================================
            mov al,  posicion[si]
            mov contaux1, ax

            Dibujar_enemigo cote2, contaux1, 0d
            mov enemigos[si], 48

            pop siaux
            push ax
            cmp siaux, 56
            jae esc2
            cmp siaux, 49
            jae esc1
            cmp siaux, 42
            jae esc0
            cmp siaux, 35
            jae esc2    
            cmp siaux, 28
            jae esc1
            cmp siaux, 21
            jae esc0
            cmp siaux, 14
            jae esc2
            cmp siaux, 7
            jae esc1
        
        esc0:
            mov decsuma, 1
            jmp suma

        esc1:
            mov decsuma, 2
            jmp suma
        esc2:
            mov decsuma, 3
            jmp suma

       suma:
            mov al, score[2]
            cmp al, 57
            je scr1
            add al, 1
            mov score[2], al
            jmp scr4
            scr1:
            mov score[2], 48
            mov al, score[1]
            cmp al, 57
            je scr2
            add al, 1
            mov score[1], al
            jmp scr4
            scr2:
            mov score[1], 48
            mov al, score[0]
            add al, 1
            mov score[0], al
        scr4:
            sub decsuma, 1
            cmp decsuma, 0
        ja suma
            pop ax
            call DS_VIDEO ;Cambio de DS a memoria de video
            xor ax, ax
            mov ah, 02h
            mov bh, 00h
            mov dh, 11d ;23 fil
            mov dl, 7d ;118 col
            int 10h
            call DS_DATOS ;Cambia de DS al lugar de las variables
            print score

            mov balas[6], 48
        jmp e111
        s1:
            mov balas[6], 48
            pop siaux
        jmp e111

        ociclo1:
            pop siaux
            inc si
            inc si
            inc siaux
        jmp ciclo1
    ;============sigo normal con la subida de la bala
    nocolison:
        Dibujar_Bala auxbala1, auxbala2, 4d

        mov ax, auxbala2
        mov balas[7], al
    jmp e111
    e11:
        mov balas[6], 48

        mov bl, balas[8]

        mov auxbala1, bx
        add auxbala1, 100

        mov auxbala2, ax
    
        Dibujar_Bala  auxbala1, auxbala2, 0d
    e111:
    pop si
    pop ax
    pop bx
ENDM



Bajar_Enemigos MACRO enemigos, posicion, retardo
LOCAL e1, e2, e3, e4, e5, vernivel1, vernivel2, finnivel2, finnivel3,vernivel3, resetcote, busco, select, v1, v2, v0, finnivel1
    push ax
    push si
    xor ax, ax
    xor si, si
    mov cote1, 0
    mov si, 0

    cmp level, 49
    je vernivel1
    cmp level, 50
    je vernivel2
    cmp level, 51
    je vernivel3

    vernivel1:
    mov al, enemigos[40]
    cmp al, 48
    je finnivel1
    jmp busco

    finnivel1:
        call Inicio_Nivel2_proc
    jmp e4

    vernivel2:
        mov al, enemigos[80]
        cmp al, 48
        je finnivel2
        jmp busco

    finnivel2:
        call Inicio_Nivel3_proc
    jmp e4

    vernivel3:
        mov al, enemigos[120]
        cmp al, 48
        je finnivel3
        jmp busco

    finnivel3:
        mov banderaTerminaJuego, 01h
        delay 2500
    jmp e4

    resetcote:
        mov cote1, 0
    busco:
        mov al, enemigos[si]
        cmp al, 49
        je select 
        inc cote1
        inc si
        inc si
        cmp cote1, 21
        je resetcote
    jne busco

    select:
        ;empiezo obteniendo la altura donde esta la nave 
        cmp cote1, 6
        ja e1 
        ; posicion horizontal
        inc cote1

        mov al, 30d
        mul cote1
        mov cote2, ax
        add cote2, 85d 

        mov al,  posicion[si]
        mov contaux1, ax

        Dibujar_enemigo cote2, contaux1, 0d
        
        add contaux1, 1
        mov ax, contaux1
        mov posicion[si], al

        cmp contaux1, 192d
        jae e3

        Dibujar_enemigo cote2, contaux1, 14d

        delay retardo
    jmp e5 ; temporal
    e1:
        cmp cote1, 13
        ja e2

        sub cote1, 6d

        mov al, 30d
        mul cote1
        mov cote2, ax
        add cote2, 85d 

        mov al,  posicion[si]
        mov contaux1, ax

        Dibujar_enemigo cote2, contaux1, 0d
        
        add contaux1, 1
        mov ax, contaux1
        mov posicion[si], al

        cmp contaux1, 192d
        jae e3

        Dibujar_enemigo cote2, contaux1, 2d

        delay retardo
    jmp e5
    e2:
        cmp cote1, 20
        ja e4

        sub cote1, 13

        mov al, 30d
        mul cote1
        mov cote2, ax
        add cote2, 85d 

        mov al,  posicion[si]
        mov contaux1, ax

        Dibujar_enemigo cote2, contaux1, 0d
        
        add contaux1, 1
        mov ax, contaux1
        mov posicion[si], al

        cmp contaux1, 192d
        jae e3

        Dibujar_enemigo cote2, contaux1, 1d


        delay retardo
    jmp e5
    e3:
        mov enemigos[si], 48

    e5:
    ;====================colision nave y enemigo============
        cmp contaux1, 170d
        jb e4

        mov ax, nx 
        cmp cote2, ax 
        jb e4

        mov auxvida, ax
        add auxvida, 15
        mov ax, auxvida
        
        cmp cote2, ax
        ja e4

        ;==========colision segun yo ===============
        mov enemigos[si], 48
        Dibujar_enemigo cote2, contaux1, 0d

        cmp lives, 3
        je v2
        cmp lives, 2
        je v1
        cmp lives, 1
        je v0

        v2:
            sub lives, 1
            FiguraCorazon 40d, 155d, 0d
            jmp e4
        v1:
            sub lives, 1
            FiguraCorazon 60d, 155d, 0d
            jmp e4
        v0:
            FiguraCorazon 80d, 155d, 0d
            ImprimirPantalla 22d, 0, limpia1
            ImprimirPantalla 22d, 0, finjuego
            mov banderaTerminaJuego, 01h
            delay 2500
            jmp e4
    e4:
    pop si 
    pop ax
ENDM

LLenarArreglo MACRO arreglo, caracter
Local Ciclo
    push si 
    push cx

	xor si,si
	xor cx,cx
	mov cx, SIZEOF arreglo

	Ciclo:
	mov arreglo[si], caracter
	inc si
	loop Ciclo

    pop cx 
    pop si
ENDM

Llenar_Posicion1 MACRO arreglo
Local Ciclo1, Ciclo3, Ciclo2, fin
    push si
    xor si, si
    mov siaux, 0
    Ciclo1:
        mov arreglo[si], 42d
        inc siaux 
        inc si 
        mov arreglo[si], 1d
        inc si
        cmp siaux, 6
        ja Ciclo2
    jmp Ciclo1
    Ciclo2:
        mov arreglo[si], 26d
        inc siaux
        inc si
        mov arreglo[si], 2d
        inc si
        cmp siaux, 13
        ja Ciclo3
    jmp Ciclo2
    Ciclo3:
        mov arreglo[si], 10d
        inc siaux 
        inc si 
        mov arreglo[si], 3d
        inc si
        cmp siaux, 20
        ja fin
    jmp Ciclo3

    fin: 
    pop si
ENDM

Llenar_Posicion2 MACRO arreglo
Local Ciclo1, Ciclo3, Ciclo2, fin, otra, cmpe, InicioC2, InicioC3
    push si
    push bx
    xor bx, bx
    xor si, si
    mov otravez, 0
    mov templlenado, 90
    otra:
        inc otravez
        mov siaux, 0
        Ciclo1:
            mov bl, templlenado
            mov arreglo[si], bl
            inc siaux 
            inc si 
            mov arreglo[si], 1d
            inc si
            cmp siaux, 6
            ja InicioC2
        jmp Ciclo1
        InicioC2:
            sub templlenado, 16
        Ciclo2:
            mov bl, templlenado
            mov arreglo[si], bl
            inc siaux
            inc si
            mov arreglo[si], 2d
            inc si
            cmp siaux, 13
            ja InicioC3
        jmp Ciclo2
        InicioC3:
            sub templlenado, 16
        Ciclo3:
            mov bl, templlenado
            mov arreglo[si], bl
            inc siaux 
            inc si 
            mov arreglo[si], 3d
            inc si
            cmp siaux, 20
            ja cmpe
        jmp Ciclo3
        cmpe:
            sub templlenado, 16
        cmp otravez, 2
    jne otra
    pop bx	
    pop si
ENDM


Llenar_Posicion3 MACRO arreglo
Local Ciclo1, Ciclo3, Ciclo2, fin, otra, cmpe, InicioC2, InicioC3
    push si
    push bx
    xor bx, bx
    xor si, si
    mov otravez, 0
    mov templlenado, 90
    otra:
        inc otravez
        mov siaux, 0
        Ciclo1:
            mov bl, templlenado
            mov arreglo[si], bl
            inc siaux 
            inc si 
            mov arreglo[si], 1d
            inc si
            cmp siaux, 6
            ja InicioC2
        jmp Ciclo1
        InicioC2:
            sub templlenado, 16
        Ciclo2:
            mov bl, templlenado
            mov arreglo[si], bl
            inc siaux
            inc si
            mov arreglo[si], 2d
            inc si
            cmp siaux, 13
            ja InicioC3
        jmp Ciclo2
        InicioC3:
            sub templlenado, 16
        Ciclo3:
            mov bl, templlenado
            mov arreglo[si], bl
            inc siaux 
            inc si 
            mov arreglo[si], 3d
            inc si
            cmp siaux, 20
            ja cmpe
        jmp Ciclo3
        cmpe:
            sub templlenado, 16
        cmp otravez, 3
    jne otra
    pop bx	
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
    
    PintarCanon cCenx, cCeny, 00h

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
LOCAL e1, e2, e3, e5, final, ef1, ef3
    PintarNave nx, ny, 0d   
    PintarCanon cCenx, cCeny, 01h
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

    PintarCanon cIzqx, cIzqy, 00h
     ;==============================cañon centro=====================
    mov cCenx, bx
    mov cCeny, cx

    add cCenx, 7
    sub cCeny, 12
    
    PintarCanon cCenx, cCeny, 00h

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

    Llenar_Posicion2 posicion_enemigos2
    LLenarArreglo enemigos_nivel2, 49d
    mov level, 50
    ImprimirPantalla 7d, 8d, level
    ImprimirPantalla 22d, 0d, limpia1
    ImprimirPantalla 22d, 0d, msg_start1

    ef1:
        getChar
        cmp al, 27
        je ef3
        cmp al, 32
        je final
    jmp ef1

    ef3:
        mov banderaTerminaJuego, 01h 

    final:
    ImprimirPantalla 22d, 0d, limpia1
    ImprimirPantalla 22d, 0d, msg_esc1
ENDM


Inicio_Nivel3 MACRO
LOCAL e1, e2, e3, e5, final, ef1, ef3
    PintarNave nx, ny, 0d   
    PintarCanon cCenx, cCeny, 01h
    PintarCanon cIzqx, cIzqy, 01h

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

    PintarCanon cIzqx, cIzqy, 00h
     ;==============================cañon centro=====================
    mov cCenx, bx
    mov cCeny, cx

    add cCenx, 7
    sub cCeny, 12
    
    PintarCanon cCenx, cCeny, 00h
    ;======================cañon derecha===================
    mov cDerx, bx
    mov cDery, cx

    add cDerx, 14
    sub cDery, 3

    PintarCanon cDerx, cDery, 00h

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

    Llenar_Posicion3 posicion_enemigos3
    LLenarArreglo enemigos_nivel3, 49d
    mov level, 51
    ImprimirPantalla 7d, 8d, level
    ImprimirPantalla 22d, 0d, limpia1
    ImprimirPantalla 22d, 0d, msg_start1

    ef1:
        getChar
        cmp al, 27
        je ef3
        cmp al, 32
        je final
    jmp ef1

    ef3:
        mov banderaTerminaJuego, 01h 

    final:
    ImprimirPantalla 22d, 0d, limpia1
    ImprimirPantalla 22d, 0d, msg_esc1
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

PintarCanon MACRO x, abajo, despintar
LOCAL e0, e1
    push si
    push cx

    xor cx, cx 
    mov cx, abajo
    mov auxnave2, cx

    mov al, despintar
    
    cmp al, 01h
    je e0

    pintar_pixel auxnave2, x, 9d
    dec auxnave2
    pintar_pixel auxnave2, x, 7d 
    dec auxnave2
    pintar_pixel auxnave2, x, 7d
    dec auxnave2
    pintar_pixel auxnave2, x, 6d
    dec auxnave2
    
    jmp e1

    e0:
        pintar_pixel auxnave2, x, 0d
        dec auxnave2
        pintar_pixel auxnave2, x, 0d 
        dec auxnave2
        pintar_pixel auxnave2, x, 0d
        dec auxnave2
        pintar_pixel auxnave2, x, 0d
        dec auxnave2


    e1:
    pop cx
    pop si

ENDM

Dibujar_Bala MACRO x, y, color 
LOCAL e0, e1
    push cx

    xor cx, cx 
    mov cx, y
    mov auxbala, cx

    pintar_pixel auxbala, x, color 
    dec auxbala
    pintar_pixel auxbala, x, color
    dec auxbala
    pintar_pixel auxbala, x, color 
    
    pop cx
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