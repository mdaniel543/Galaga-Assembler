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
        print salto
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
        OrdenarMiMarcador

        print msgMarcador11
        print bufferU
        print salto
        print msgLine2
        print msgMarcador2 
        print msgline_

        print salto
        print salto
        print salto


        print msgenterCo
    e2:
        getTecla
        cmp ah, 1Ch 
    jne e2
ENDM 


ObtenerScores MACRO 
LOCAL e1, e2, e3
    push si
    xor si, si
    mov conteo_scores, 0
    e1:
        mov al, scores[si]
        cmp al, 36 
        je e3
        cmp al, 13
        jne e2 
        inc conteo_scores
        e2:
            mov al, scores[si]
            mov scoresOrdenados[si], al
            inc si 
    jmp e1
    e3:
    pop si 
ENDM 


OrdenarMarcador MACRO 
Local for1, for2, regfor2, regfor1, res, ciclo_i, ciclo_j, pos_i, punteo_i, ciclo_j
    push ax
    push bx
    push si
    xor ax, ax
    xor bx, bx
    xor si, si 

    mov i, 0
    mov j, 0
    

    for1:
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
            mov al, j
            cmp ax, conteo_scores
            jae regfor1 ; mayor o igual


            ;==============obtengo el valor en la posicion i========
            mov conteo_auxiliar, 0
            xor si, si 

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
            mov bx, auxw
            mov auxwj, bx

            
        

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



OrdenarMiMarcador MACRO 
    
ENDM