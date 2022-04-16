GuardarScore MACRO 
    CrearArchivo ArchivoRutaScore, ArchivoHandlerScore
    EscribirScore 
    CerrarArchivo ArchivoHandlerScore
ENDM

LeerScore MACRO
    LimpiarArreglo scores
    AbrirArchivo ArchivoRutaScore, ArchivoHandlerScore
    LecturaScores ArchivoHandlerScore
    CerrarArchivo ArchivoHandlerScore
ENDM

LecturaScores MACRO handler
    push ax
    push bx
    push cx
    push dx
   
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

    mov ah, 3fh
    mov bx,  handler
    mov cx, SIZEOF scores
    lea dx, scores 
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
ENDM


EscribirScore MACRO
LOCAL e0, e1, e2, e3, e4, e5, e6, e7, e1x
    e0:
        push si
        push di
        xor si, si
        xor di, di
    e1:
        mov al, scores[si]
        cmp al, 36
        je e2
        EscribirArchivoS scores[si]
        inc si
    jmp e1
    e2:
        mov al, bufferU[di]
        cmp al, 36
        je e3
        mov scores[si], al
        EscribirArchivoS scores[si]
        inc si
        inc di 
    jmp e2
    e3:
        ;=========escribo la coma============
        mov al, 44
        mov scores[si], al
        EscribirArchivoS scores[si]
        inc si
        ;=======escribo el nivel que llego========]
        mov al, level
        mov scores[si], al
        EscribirArchivoS scores[si]
        inc si 
        ;===========escribo el punto coma===========
        mov al, 59
        mov scores[si], al
        EscribirArchivoS scores[si]
        inc si

        xor di, di
    e4:
       ;======escribo el punteo============
        mov al, score[di]
        cmp al, 36
        je e5
        mov scores[si], al
        EscribirArchivoS scores[si]
        inc si
        inc di
    jmp e4
    
    e5:
        ;============escribo la comilla simple============== 
        mov al, 39
        mov scores[si], al
        EscribirArchivoS scores[si]
        inc si
        xor di, di
    e6:
        ;===========escribo el tiempo=============
        mov al, time[di]
        cmp al, 36
        je e7
        mov scores[si], al
        EscribirArchivoS scores[si]
        inc si
        inc di
    jmp e6
    e7:
        mov al, 13 
        mov scores[si], al
        EscribirArchivoS scores[si]

    pop di
    pop si

ENDM

EscribirArchivoS MACRO arreglo
Local Inicio,Final
	mov al, arreglo
	cmp al, 36
	je Final

	Inicio:
	mov ah, 40h
	mov bx, ArchivoHandlerScore
	mov cx, 01h
	lea dx, arreglo
	int 21h
	jc Error	

	Final:
ENDM


Inicio_Marcador MACRO 
LOCAL e1, e2, e3, e4, e5
    e1:
        ObtenerScores
        OrdenarMarcador

        print msgMarcador1
        print bufferU
        print salto
        print msgLine2
        print msgMarcador2 
        print msgline_

        print salto
        Mostrar_Marcador
        print salto 

        print msgenterCo
    e2:
        getTecla
        cmp ah, 1Ch 
    jne e2
ENDM 

Inicio_Mi_Marcador MACRO 
LOCAL e1, e2, e3, e4, e5
    e1:
        ObtenerScores
        OrdenarMarcador

        print msgMarcador11
        print bufferU
        print salto
        print msgLine2
        print msgMarcador2 
        print msgline_

        print salto
        Mostrar_Mi_Marcador
        print salto 

        print msgenterCo
    e2:
        getTecla
        cmp ah, 1Ch 
    jne e2
ENDM 


ImprimirArreglo MACRO arreglo
Local Ciclo, jr, jrs
	xor si,si
	xor cx,cx
	mov cx, SIZEOF arreglo

	Ciclo:
    mov al, arreglo[si]
    cmp al, 13
    je jr 
	mov sd, al
    print sd
    jmp jrs
	jr:
    print salto
    jrs:
    inc si
	loop Ciclo
ENDM

Mostrar_Marcador MACRO 
LOCAL coma, puntoycoma, comilla, enter, usuario, us, tiempo, siguiente, fin
    push si
    xor si, si
    mov rank, 49

    usuario:
        print rank
        print sangria1
    us:
        mov al, scoresOrdenados[si]
        inc si
        cmp al, 44
        je coma
        mov caracterP, al
        print caracterP
    jmp us

    coma:
        print sangria2
        mov al, scoresOrdenados[si]
        mov caracterP, al
        print caracterP
        print sangria2
        inc si 
        inc si 
        mov al, scoresOrdenados[si]
        mov caracterP, al
        print caracterP
        inc si
        mov al, scoresOrdenados[si]
        mov caracterP, al
        print caracterP
        inc si
        mov al, scoresOrdenados[si]
        mov caracterP, al
        print caracterP
        inc si
        inc si
        print sangria1
    tiempo:
        mov al, scoresOrdenados[si]
        mov caracterP, al
        inc si 
        cmp al, 13
        je siguiente
        print caracterP
    jmp tiempo

    siguiente:
        mov al, scoresOrdenados[si]
        cmp al, 36
        je fin
        add rank, 1
        print salto
    jmp usuario

    fin:
    pop si 
ENDM

Mostrar_Mi_Marcador MACRO 
LOCAL coma, puntoycoma, comilla, enter, usuario, us,sup, tiempo,otro_usuario, siguiente, fin
    push si
    push di
    xor si, si
    xor di, di
    mov rank, 48
    
    push si 
    siguiente:
        mov al, scoresOrdenados[si]
        cmp al, 36
        je fin 
        inc si
        cmp al, 32
        je siguiente
        cmp al, 44
        je usuario
        cmp al, bufferU[di]
        jne otro_usuario
        inc di 
    jmp siguiente        


    otro_usuario: 
        mov al, scoresOrdenados[si]
        inc si
        cmp al, 13
    jne otro_usuario
    sup:
        xor di, di
        push si
    jmp siguiente


    usuario:
        pop si 
        add rank, 1
        print salto
        print rank
        print sangria1
    us:
        mov al, scoresOrdenados[si]
        inc si
        cmp al, 44
        je coma
        mov caracterP, al
        print caracterP
    jmp us

    coma:
        print sangria2
        mov al, scoresOrdenados[si]
        mov caracterP, al
        print caracterP
        print sangria2
        inc si 
        inc si 
        mov al, scoresOrdenados[si]
        mov caracterP, al
        print caracterP
        inc si
        mov al, scoresOrdenados[si]
        mov caracterP, al
        print caracterP
        inc si
        mov al, scoresOrdenados[si]
        mov caracterP, al
        print caracterP
        inc si
        inc si
        print sangria1

    tiempo:
        mov al, scoresOrdenados[si]
        mov caracterP, al
        inc si 
        cmp al, 13
        je sup
        print caracterP
    jmp tiempo

    fin:
    pop di
    pop si 
ENDM

ObtenerScores MACRO 
LOCAL e1, e2, e3, e4, e5
    push si
    push di 
    xor si, si
    xor di, di

    mov conteo_scores, 0
    mov cont_caracteres, 1
    e1:
        mov al, scores[di]
        cmp al, 36 
        je e3
        cmp al, 13
        jne e2 
        mov cont_caracteres, 0
        inc conteo_scores
        e2:
            cmp al, 44
            jne e4
        e5:
            cmp cont_caracteres, 15
            je e4 
            mov scoresOrdenados[si], 32
            inc cont_caracteres
            inc si
        jmp e5
        e4:
            mov al, scores[di]
            mov scoresOrdenados[si], al
            inc cont_caracteres
            inc si 
            inc di 
    jmp e1
    e3:
    pop di
    pop si 
ENDM 


OrdenarMarcador MACRO 
Local for1, for2, regfor2, regfor1, res, ciclo_i, ciclo_j, pos_i, punteo_i,pos_j, punteo_j, guardar, cambiar, ccambiar, sscar, sacar
    push ax
    push bx
    push si
    push di 
    xor ax, ax
    xor bx, bx
    xor si, si 

    mov i, 0
    mov j, 0
    
    for1:
        xor ax, ax
        mov al, i
        cmp ax, conteo_scores
        jae res ; mayor o igual

        ;==============obtengo el valor en la posicion i========
        
        mov conteo_auxiliar, 0
        xor si, si

        mov al, i 
        cmp conteo_auxiliar, ax ; solo para saber si i = 0
        je pos_i
        
        ;============me posicion en el usuario de i============
        ciclo_i:
            mov al, scoresOrdenados[si]
            inc si 
            cmp al, 13
        jne ciclo_i
            inc conteo_auxiliar
            mov al, i 
            cmp conteo_auxiliar, ax
            je pos_i
        jmp ciclo_i

        ;=============busco el score del usuario=======
        pos_i: 
            mov guardar_inicio_i, si 
        punteo_i:
            mov al, scoresOrdenados[si]
            inc si 
            cmp al, 59
        jne punteo_i
        ;==============con el score lo junto =======
        mov al, scoresOrdenados[si]
        mov uaxb[0], al
        inc si 
        mov al, scoresOrdenados[si]
        mov uaxb[1], al
        inc si 
        mov al, scoresOrdenados[si]
        mov uaxb[2], al
        
        SacarPunteo uaxb
        mov bx, auxw
        mov auxwi, bx

        mov al, i 
        add al, 1
        mov j, al

        for2:
            xor ax, ax
            mov al, j
            cmp ax, conteo_scores
            jae regfor1 ; mayor o igual

            ;==============obtengo el valor en la posicion j========
            mov conteo_auxiliar, 0
            xor si, si 
            xor ax, ax
            ;============me posicion en el usuario de j============
            ciclo_j:
                mov al, scoresOrdenados[si]
                inc si 
                cmp al, 13
            jne ciclo_j
                inc conteo_auxiliar
                mov al, j
                cmp conteo_auxiliar, ax
                je pos_j
            jmp ciclo_j

            ;=============busco el score del usuario=======
            pos_j: 
                mov guardar_inicio_j, si 
            punteo_j:
                mov al, scoresOrdenados[si]
                inc si 
                cmp al, 59
            jne punteo_j
            ;==============con el score lo junto =======
            mov al, scoresOrdenados[si]
            mov uaxb[0], al
            inc si 
            mov al, scoresOrdenados[si]
            mov uaxb[1], al
            inc si 
            mov al, scoresOrdenados[si]
            mov uaxb[2], al
            
            SacarPunteo uaxb
            
            xor bx, bx
            mov bx, auxw
            mov auxwj, bx

            xor ax, ax
            mov ax, auxwi ; aux[i] < aux[j]
            cmp ax, auxwj
            jae regfor2 

            mov ax, auxwj
            mov auxwi, ax
            xor ax, ax
            LimpiarArreglo auxaux
            xor si, si
            xor di, di  
            mov si, guardar_inicio_i
            
            guardar:
                mov al, scoresOrdenados[si]
                mov auxaux[di], al 
                inc si 
                inc di
                cmp al, 13
            jne guardar  

                xor si, si
                xor di, di
                mov si, guardar_inicio_i
                mov di, guardar_inicio_j

            ccambiar:
                mov al, scoresOrdenados[di]
                mov scoresOrdenados[si], al 
                inc si 
                inc di 
                cmp al,13
            jne ccambiar
                xor si, si
                xor di, di
                mov si, guardar_inicio_j
            sscar:
                mov al, auxaux[di]
                mov scoresOrdenados[si], al
                inc si 
                inc di 
                cmp al, 13
            jne sscar

            regfor2:
                xor ax, ax
                mov al, j
                add al, 1
                mov j, al
        jmp for2

        regfor1:
            xor ax, ax
            mov al, i
            add al, 1
            mov i, al
    jmp for1

    res:

    pop di 
    pop si 
    pop bx
    pop ax
ENDM

SacarPunteo MACRO sc
LOCAL d, u, f
    push ax
    push bx

    xor ax, ax
    xor bx, bx 
    mov auxw, 0

    mov al, sc[0]
    cmp al, 48
    je d

    sub al, 48
    mov bl, 100
    mul bl
    mov auxw, ax

    d:
        mov al, sc[1]
        cmp al, 48
        je u
        
        sub al, 48
        mov bl, 10
        mul bl
        add auxw, ax
    u:
        mov al, sc[2]
        cmp al, 48
        je f

        sub al, 48
        mov bl, 1
        mul bl
        add auxw, ax
    f: 
    pop bx   
    pop ax
ENDM
