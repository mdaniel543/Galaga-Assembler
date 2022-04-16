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

Burbuja MACRO
LOCAL tiempo, punto, f, h, as
    limpiar
    mov al, banderaTiempo
    cmp al, 01h
    je tiempo
    jne punto
   
    tiempo:
        Imprimir 88
        jmp f
    punto:
        ImprimirArreglo16 punteos
        cmp banderaAscendente, 01h
        je as
        Ordena_Burbuja_Desc
        jmp h
        as:
            Ordena_Burbuja_Asc
        h:
        ImprimirArreglo16 punteos
        jmp f 
    f:
    getTecla
ENDM

Heap MACRO


ENDM

Tim MACRO 

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