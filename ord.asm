Menu_Burbuja MACRO
LOCAL e1, e2, e3, e4, e5, e6, e7, e8, e9 , e10,v1, v2, v3, v4, v5, v6, v7, v8, f, re1,re2, re3
    LimpiarArreglo scoresOrdenados
    ObtenerScores ; solo para sacar la cantidad de scores 
    e1:
        print msg01
        print bufferU
        print salto
        print msgLine2
        print msgsubMenu
        getTecla
        cmp ah, 3BH; F1
        je e2
        cmp ah, 3CH; f2
        je e3
        cmp ah, 43h; f9
        je f
    limpiar
    jmp e1
    e2: 
        mov banderaAscendente, 01h
        jmp e4
    e3:
        mov banderaDescendente, 01h
        jmp e4
    e4:
        limpiar
        print msg01
        print bufferU
        print salto
        print msgLine2
        print msgsubMenu2 
        getTecla
        cmp ah, 3BH; F1
        je e5
        cmp ah, 3CH; f2
        je e6
        cmp ah, 43h; f9
        je re2
    jmp e4
    
    e5:
        mov banderaPuntos, 01h
        jmp e7
    e6:
        mov banderaTiempo, 01h
        jmp e7

    re2:
        mov banderaAscendente, 00h
        mov banderaDescendente, 00h
        limpiar
        jmp e1

    e7:
        limpiar
        print msg01
        print bufferU
        print salto
        print msgLine
        print msgSubMenu3
        getTecla
        cmp ah, 3Bh; F1 
        je v1
        cmp ah, 3Ch; F2 
        je v2
        cmp ah, 3Dh; F3 
        je v3
        cmp ah, 3Eh; F4 
        je v4
        cmp ah, 3Fh ; F5 
        je v5
        cmp ah, 40h; F6
        je v6
        cmp ah, 41h; F7
        je v7
        cmp ah, 42h; F8 
        je v8
        cmp ah, 43h; F9 
        je re3
    jmp e7

    v1:
        mov velocidad, 150
        mov veloci, 48
        jmp e8
    v2:
        mov veloci, 49
        mov velocidad, 140
        jmp e8
    v3:
        mov veloci, 50
        mov velocidad, 130
        jmp e8
    v4:
        mov veloci, 51
        mov velocidad, 120
        jmp e8
    v5:
        mov veloci, 52
        mov velocidad, 110
        jmp e8
    v6:
        mov veloci, 53
        mov velocidad, 100
        jmp e8
    v7:
        mov veloci, 54
        mov velocidad, 90
        jmp e8
    v8:
        mov veloci, 55
        mov velocidad, 80
        jmp e8
    
    e8:
        Burbuja 
        jmp f
    re3:
        mov banderaPuntos, 00h
        mov banderaTiempo, 00h
        limpiar
        jmp e4

    f:
    limpiar
ENDM

Menu_Heap MACRO
LOCAL e1, e2, e3, e4, e5, e6, e7, e8, e9 , e10,v1, v2, v3, v4, v5, v6, v7, v8, f, re1,re2, re3
    LimpiarArreglo scoresOrdenados
    ObtenerScores ; solo para sacar la cantidad de scores 
    e1:
        print msg02
        print bufferU
        print salto
        print msgLine2
        print msgsubMenu
        getTecla
        cmp ah, 3BH; F1
        je e2
        cmp ah, 3CH; f2
        je e3
        cmp ah, 43h; f9
        je f
    limpiar
    jmp e1
    e2: 
        mov banderaAscendente, 01h
        jmp e4
    e3:
        mov banderaDescendente, 01h
        jmp e4
    e4:
        limpiar
        print msg02
        print bufferU
        print salto
        print msgLine2
        print msgsubMenu2 
        getTecla
        cmp ah, 3BH; F1
        je e5
        cmp ah, 3CH; f2
        je e6
        cmp ah, 43h; f9
        je re2
    jmp e4
    
    e5:
        mov banderaPuntos, 01h
        jmp e7
    e6:
        mov banderaTiempo, 01h
        jmp e7

    re2:
        mov banderaAscendente, 00h
        mov banderaDescendente, 00h
        limpiar
        jmp e1

    e7:
        limpiar
        print msg02
        print bufferU
        print salto
        print msgLine2
        print msgSubMenu3
        getTecla
        cmp ah, 3Bh; F1 
        je v1
        cmp ah, 3Ch; F2 
        je v2
        cmp ah, 3Dh; F3 
        je v3
        cmp ah, 3Eh; F4 
        je v4
        cmp ah, 3Fh ; F5 
        je v5
        cmp ah, 40h; F6
        je v6
        cmp ah, 41h; F7
        je v7
        cmp ah, 42h; F8 
        je v8
        cmp ah, 43h; F9 
        je re3
    jmp e7

    v1:
        mov velocidad, 150
        jmp e8
    v2:
        mov velocidad, 135
        jmp e8
    v3:
        mov velocidad, 120
        jmp e8
    v4:
        mov velocidad, 105
        jmp e8
    v5:
        mov velocidad, 90
        jmp e8
    v6:
        mov velocidad, 75
        jmp e8
    v7:
        mov velocidad, 60
        jmp e8
    v8:
        mov velocidad, 55
        jmp e8
    
    e8:
        Heap
        jmp f
    re3:
        mov banderaPuntos, 00h
        mov banderaTiempo, 00h
        limpiar
        jmp e4

    f:
    limpiar
ENDM

Menu_Tim MACRO
LOCAL e1, e2, e3, e4, e5, e6, e7, e8, e9 , e10,v1, v2, v3, v4, v5, v6, v7, v8, f, re1, re2, re3
    LimpiarArreglo scoresOrdenados
    ObtenerScores ; solo para sacar la cantidad de scores 
    e1:
        print msg03
        print bufferU
        print salto
        print msgLine2
        print msgsubMenu
        getTecla
        cmp ah, 3BH; F1
        je e2
        cmp ah, 3CH; f2
        je e3
        cmp ah, 43h; f9
        je f
    limpiar
    jmp e1
    e2: 
        mov banderaAscendente, 01h
        jmp e4
    e3:
        mov banderaDescendente, 01h
        jmp e4
    e4:
        limpiar
        print msg03
        print bufferU
        print salto
        print msgLine2
        print msgsubMenu2 
        getTecla
        cmp ah, 3BH; F1
        je e5
        cmp ah, 3CH; f2
        je e6
        cmp ah, 43h; f9
        je re2
    jmp e4
    
    e5:
        mov banderaPuntos, 01h
        jmp e7
    e6:
        mov banderaTiempo, 01h
        jmp e7

    re2:
        mov banderaAscendente, 00h
        mov banderaDescendente, 00h
        limpiar
        jmp e1

    e7:
        limpiar
        print msg03
        print bufferU
        print salto
        print msgLine2
        print msgSubMenu3
        getTecla
        cmp ah, 3Bh; F1 
        je v1
        cmp ah, 3Ch; F2 
        je v2
        cmp ah, 3Dh; F3 
        je v3
        cmp ah, 3Eh; F4 
        je v4
        cmp ah, 3Fh ; F5 
        je v5
        cmp ah, 40h; F6
        je v6
        cmp ah, 41h; F7
        je v7
        cmp ah, 42h; F8 
        je v8
        cmp ah, 43h; F9 
        je re3
    jmp e7

    v1:
        mov velocidad, 150
        jmp e8
    v2:
        mov velocidad, 135
        jmp e8
    v3:
        mov velocidad, 120
        jmp e8
    v4:
        mov velocidad, 105
        jmp e8
    v5:
        mov velocidad, 90
        jmp e8
    v6:
        mov velocidad, 75
        jmp e8
    v7:
        mov velocidad, 60
        jmp e8
    v8:
        mov velocidad, 55
        jmp e8
    
    e8:
        Tim
        jmp f
    re3:
        mov banderaPuntos, 00h
        mov banderaTiempo, 00h
        limpiar
        jmp e4

    f:
    limpiar
ENDM

Heap MACRO

ENDM

Tim MACRO 

ENDM

Burbuja MACRO
LOCAL tiempo, punto, f, h, as
    limpiar
    mov al, banderaPuntos
    cmp al, 01h
    je punto
    jne f
   
    punto:
        ;ImprimirArreglo16 punteos
        ;cmp banderaAscendente, 01h
        ;je as
        ;Ordena_Burbuja_Desc
        ;jmp h
        ;as:
           ; Ordena_Burbuja_Asc
        ;h:
        ;ImprimirArreglo16 punteos
        call ModoGraficoOrdenamiento_proc
    f:
ENDM

ImprimirArreglo16 MACRO arreglo
LOCAL e1, e2, e3, e4, e5, e16
    push si 
    push di 
    xor si, si
    xor di, di
    xor ax, ax
    e1:
        print salto
        mov al, arreglo[si] 
        cmp al, 36
        je e2
        mov bl, al
        mov ax, bx 


        push si
        ConvertirString teste
        print teste
        pop si 
        inc si
    jmp e1

    e2:
    pop di 
    pop si 
ENDM 

Ordena_Burbuja_Desc MACRO 
Local for1, for2, regfor1, regfor2, res
    push ax
    push bx
    xor bx, bx 
    xor ax, ax
    mov i, 0
    mov j, 0
    mov auxiliar_burbuja1, 0
    mov auxiliar_burbuja2, 0
    for1:
        mov al, i
        cmp ax, conteo_scores
        jae res ; mayor o igual

        add al, 1
        mov j, al 
        for2:
            mov al, j
            cmp ax, conteo_scores
            jae regfor1 ; mayor o igual
            
            mov bl, i 
            mov al, punteos[bx]
            mov auxiliar_burbuja1, al

            mov bl, j
            mov bl, punteos[bx]
            mov auxiliar_burbuja2, bl 

            cmp al, bl
            jae regfor2

            mov bl, i
            mov al, auxiliar_burbuja2 ; i = j 
            mov punteos[bx], al

            mov bl, j
            mov al, auxiliar_burbuja1
            mov punteos[bx], al

            regfor2:
                mov al, j
                add al, 1
                mov j, al
        jmp for2

        regfor1:
            mov al, i
            add al, 1
            mov i, al
    jmp for1

    res:

    pop bx
    pop ax
ENDM

Ordena_Burbuja_Asc MACRO 
Local for1, for2, regfor1, regfor2, res
    push ax
    push bx
    xor bx, bx 
    xor ax, ax
    mov i, 0
    mov j, 0
    mov auxiliar_burbuja1, 0
    mov auxiliar_burbuja2, 0
    for1:
        mov al, i
        cmp ax, conteo_scores
        jae res ; mayor o igual

        add al, 1
        mov j, al 
        for2:
            mov al, j
            cmp ax, conteo_scores
            jae regfor1 ; mayor o igual
            
            mov bl, i 
            mov al, punteos[bx]
            mov auxiliar_burbuja1, al

            mov bl, j
            mov bl, punteos[bx]
            mov auxiliar_burbuja2, bl 

            cmp al, bl
            jbe regfor2

            mov bl, i
            mov al, auxiliar_burbuja2 ; i = j 
            mov punteos[bx], al

            mov bl, j
            mov al, auxiliar_burbuja1
            mov punteos[bx], al

            regfor2:
                mov al, j
                add al, 1
                mov j, al
        jmp for2

        regfor1:
            mov al, i
            add al, 1
            mov i, al
    jmp for1

    res:

    pop bx
    pop ax
ENDM

pintar_S_linea MACRO izq, arr, aba, color
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

ModoGraficoOrdenamiento MACRO 
LOCAL e1, e2, e3, e4, e5, g, dibujar_a

    mov time[7], 48
    mov time[6], 48
    mov time[4], 48
    mov time[3], 48
    mov time[1], 48
    mov time[0], 48

    ModoGrafico

    ImprimirPantalla 0, 0, buble
    call DS_DATOS
    cmp banderaAscendente, 01h
    je dibujar_a
        Dibujar_flecha_1 70, 5, 11
        jmp g
    jmp g
    dibujar_a:
        Dibujar_flecha_2 70, 5, 11
        jmp g
    g:
    pintar_S_linea 35, 13d, 180d, 8
    ImprimirPantalla 0, 54, vel
    ImprimirPantalla 0, 64, veloci
    ImprimirPantalla 0d, 112d, time 
    pintar_linea_ho 12d, 180d, 3d
    ImprimirPantalla 21, 56, pun 
    ImprimirPantalla 23, 46, home 
    PantallaArreglo
    delay 5000
    ModoTexto

ENDM 

pintar_linea_ho MACRO arr, abj, color
LOCAL ciclo1, ciclo2
    push si
    xor si, si

    ciclo2:
        pintar_pixel arr, si, color
        inc si
        cmp si, 319
    jne ciclo2


    xor si, si 
    ciclo1:
        pintar_pixel abj, si, color
        inc si
        cmp si, 319
    jne ciclo1

    pop si
ENDM

Inicio_Tiempo_Ordenar MACRO 
LOCAL e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, level1, level2, l, level3
    e1:
        cmp banderaTerminaOrdenamiento, 01h
        je e10

        delay velocidad

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
            
            cmp al, 54
            je e3
        e2:
        ImprimirPantalla 0d, 100d, time
        
        
    jmp e1

    e3:
        delay velocidad

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
            
            cmp al, 54
            je e6   
        e4:
        
        ImprimirPantalla 0d, 100d, time

    jmp e1

    e6:
        delay velocidad
    
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
            
            cmp al, 54
            je e10  
        e8:
        
        ImprimirPantalla 0d, 100d, time

    jmp e1

    e10:
ENDM


Dibujar_flecha_1 MACRO x, y, color
LOCAL e2, ciclo1, e1,  e7, e8, e9
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
            cmp contador5, 1
        jne e1
        mov contador5, 0
        add auxnave2, 1
        mov si, auxnave2
        sub auxnave, 1
        cmp contador3, 4
    jne e2

    xor cx, cx
    mov cx, y
    mov contador5, cx
    xor si, si
    mov contador4, 0
    mov contador3, 0
    e8:
        mov contador3, 0
        inc contador4
        dec contador5 
        cmp contador4, 4
        je e9
        mov si, x
        add si, 2
    e7: 
        inc contador3
        pintar_pixel contador5, si, color 
        inc si 
        cmp contador3, 4
    jne e7  
    jmp e8
    e9:


    pop cx
    pop si
ENDM

Dibujar_flecha_2 MACRO x, y, color
LOCAL e2, ciclo1, e1, e7, e8, e9
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
            dec contador4
            cmp contador5, 1
        jne e1
        mov contador5, 0
        add auxnave2, 1
        mov si, auxnave2
        sub auxnave, 1
        cmp contador3, 4
    jne e2

    xor cx, cx
    mov cx, y
    mov contador5, cx
    xor si, si
    mov contador4, 0
    mov contador3, 0
    e8:
        mov contador3, 0
        inc contador4
        inc contador5 
        cmp contador4, 4
        je e9
        mov si, x
        add si, 2
    e7: 
        inc contador3
        pintar_pixel contador5, si, color 
        inc si 
        cmp contador3, 4
    jne e7  
    jmp e8
    e9:
    pop cx
    pop si
ENDM


Dibujar_flecha_3 MACRO x, y, color
LOCAL e2, ciclo1, e1,  e7, e8, e9
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
                pintar_pixel si, contador4, color 
                inc si 
                cmp si, auxnave
            jne ciclo1
            inc contador4
            cmp contador5, 1
        jne e1
        mov contador5, 0
        add auxnave2, 1
        mov si, auxnave2
        sub auxnave, 1
        cmp contador3, 4
    jne e2


    pop cx
    pop si
ENDM


PantallaArreglo MACRO 
LOCAL e1, e2, e3, e4, e5, e16
    push si 
    push di 
    push ax
    push bx
    xor si, si
    xor di, di
    xor al,al
	xor ax,ax
    xor bl, bl
    xor bx, bx

    mov posicio_div, 0
    mov posicion_grafica, 0
    
    mov al, 20
    mov bx, conteo_scores
    div bl
    mov posicio_div, al

    e1:
        print salto
        mov al, punteos[si] 
        cmp al, 36
        je e2

        push si
        mov bl, al
        mov ax, bx 

        ConvertirString teste
        xor al, al
        mov al, posicio_div
        add posicion_grafica, al
        ImprimirPantalla2 posicion_grafica, 1, teste

        pop si 
        xor ax, ax
        xor al, al
        mov al, punteos[si]
        add al, 125
        mov posicion_final, ax

        mov al, posicion_grafica
        mov bl, 8
        mul bl
        mov posicion_pixeles, ax

        Barras posicion_pixeles, posicion_final, 10d
        Dibujar_flecha_3 posicion_pixeles, 2, 12d
        inc si
    jmp e1

    e2:
    pop bx
    pop ax
    pop di 
    pop si 
ENDM 

ImprimirPantalla2 MACRO  fila, columna, cadena 
    push ax
        call DS_VIDEO ;Cambio de DS a memoria de video
        xor ax, ax
	    mov ah, 02h
	    mov bh, 00h
        call DS_DATOS 
	    mov dh, fila ;23 fil
	    mov dl, columna ;118 col
	    int 10h
        print cadena
    pop ax
ENDM

Barras MACRO inicio, fin, color 
LOCAL ciclo1, ciclo2
    push si
    push ax
    xor ax, ax
    xor si, si
    mov si, inicio
    mov contador5, 0
    mov contador3, 40
    ciclo2:
        inc contador5 
        pintar_pixel si, contador3, color
        inc si
        cmp contador5, 8 
    jne ciclo2
        mov contador5, 0
        mov si, inicio
        inc contador3
        mov ax, fin
        cmp contador3, ax 
    jb ciclo2

    pop ax
    pop si
ENDM
