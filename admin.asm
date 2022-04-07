MenuAdminGeneral MACRO 
Local desb, asc, des, bub, hea, tim, lout, fin, Menue, f
    Menue:
        print msgAdminMenu
        print bufferU
        print salto
        print msgLine
        print msgOpcionesAG
        getTecla
        cmp ah, 3Bh; F1 desbloquear
        je desb
        cmp ah, 3Ch; F2 Ascender
        je asc
        cmp ah, 3Dh; F3 Descender
        je des
        cmp ah, 3Fh; F5 Bubble 
        je bub
        cmp ah, 40h ; F6 Heap
        je hea
        cmp ah, 41h; F7 Tim
        je tim
        cmp ah, 43h; F9 Logut
        je lout
        jmp Menue
    desb:
        limpiar
        Desbloquear
        jmp fin
    asc:
        limpiar
        Ascender
        jmp fin
    des:
        limpiar
        Descender
        jmp fin
    bub:
        jmp fin
    hea: 
        jmp fin
    tim:
        jmp fin
    lout:
        jmp f
    fin:
        jmp Menue
    f:
    limpiar
    print msgCerrarSession
    print salto
ENDM

MenuAdmin MACRO
    Local desb, asc, des, bub, hea, tim, lout, fin, Menue, f
    Menue:
        print msgAdminMenu
        print bufferU
        print salto
        print msgLine
        print msgOpcionesA
        getTecla
        cmp ah, 3Bh; F1 desbloquear
        je desb
        cmp ah, 3Ch; F2 10 tops
        je asc
        cmp ah, 3Dh; F3 Mis 10 tops
        je des
        cmp ah, 3Eh; F4 Mis 10 tops
        je play
        cmp ah, 3Fh; F5 Bubble 
        je bub
        cmp ah, 40h ; F6 Heap
        je hea
        cmp ah, 41h; F7 Tim
        je tim
        cmp ah, 43h; F9 Logut
        je lout
        jmp Menue
    desb:
        limpiar
        Desbloquear
        jmp fin
    asc:
        jmp fin
    des:
        jmp fin
    play:
        jmp fin
    bub:
        jmp fin
    hea: 
        jmp fin
    tim:
        jmp fin
    lout:
        jmp f
    fin:
        jmp Menue
    f:
    limpiar
    print msgCerrarSession
    print salto
ENDM

Desbloquear MACRO 
LOCAL ini, user, buscar, b1, b2, b3, b4, b5, final, b41, desbl, nb
    print msgAdminUnlock 
    print bufferU
    print salto
    print msgLine
    print salto 
    print msgUnlock 
    ;=========================ingreso el nombrel usuario ================
    ini: 
        LimpiarArreglo bufferUnlock
        xor si, si
    user:
        getChar
        cmp al, 13
        je buscar 
        mov bufferUnlock[si], al
        inc si
        jmp user
    ;=============empiezo a buscar el usuario ==================
    buscar:
        xor di, di
    b1:
        xor si, si
    b2:
        mov al, users[di]
        cmp al, 44
        je b4 
        cmp al, bufferUnlock[si]
        jne b3
        inc si 
        inc di
        jmp b2
    ;====================busco el otro usuario=================
    b3:
        mov al, users[di]
        inc di
        cmp al, 13
        je b1 
        cmp al, 36
        je b5
        jmp b3
    ;====================empiezo a desbloquear======================
    b4:
        inc di
        mov al, users[di]
        cmp al, 44
        je b41
        jmp b4
    b41:    
        inc di
        mov al, users[di]
        cmp al, 49 
        je desbl
        jne nb 
    desbl:
        mov users[di], 48
        ActualizarUsers
        print msgUnlock1
        getChar
        limpiar
        jmp final
    nb:
        print msgUnlock2
        getChar
        limpiar
        jmp final
    ;==============el usuario que ingreso no existe lo resgreso al menu
    b5:
        limpiar
        print msgNoExisteUser
        getChar
        limpiar
        jmp final
    final:

ENDM

Ascender MACRO 
LOCAL ini, user, buscar, b1, b2, b3, b4, b5, final, b41, desbl, nb
    print msgAscender 
    print bufferU
    print salto
    print msgLine
    print salto 
    print msgAscender1 
    ;=========================ingreso el nombrel usuario ================
    ini: 
        LimpiarArreglo bufferBan
        xor si, si
    user:
        getChar
        cmp al, 13
        je buscar 
        mov bufferBan[si], al
        inc si
        jmp user
    ;=============empiezo a buscar el usuario ==================
    buscar:
        xor di, di
    b1:
        xor si, si
    b2:
        mov al, users[di]
        cmp al, 44
        je b4 
        cmp al, bufferBan[si]
        jne b3
        inc si 
        inc di
        jmp b2
    ;====================busco el otro usuario=================
    b3:
        mov al, users[di]
        inc di
        cmp al, 13
        je b1 
        cmp al, 36
        je b5
        jmp b3
    ;====================empiezo a desbloquear======================
    b4:
        inc di
        mov al, users[di]
        cmp al, 44
        je b41
        jmp b4
    b41: 
        inc di
        inc di
        inc di
        mov al, users[di]
        cmp al, 48 
        je desbl
        jne nb 
    desbl:
        mov users[di], 49
        ActualizarUsers
        print msgAscender2
        getChar
        limpiar
        jmp final
    nb:
        print msgAscender3
        getChar
        limpiar
        jmp final
    ;==============el usuario que ingreso no existe lo resgreso al menu
    b5:
        limpiar
        print msgNoExisteUser
        getChar
        limpiar
        jmp final
    final:
ENDM

Descender MACRO
LOCAL ini, user, buscar, b1, b2, b3, b4, b5, final, b41, desbl, nb
    print msgDescender 
    print bufferU
    print salto
    print msgLine
    print salto 
    print msgDescender1 
    ;=========================ingreso el nombrel usuario ================
    ini: 
        LimpiarArreglo bufferBan
        xor si, si
    user:
        getChar
        cmp al, 13
        je buscar 
        mov bufferBan[si], al
        inc si
        jmp user
    ;=============empiezo a buscar el usuario ==================
    buscar:
        xor di, di
    b1:
        xor si, si
    b2:
        mov al, users[di]
        cmp al, 44
        je b4 
        cmp al, bufferBan[si]
        jne b3
        inc si 
        inc di
        jmp b2
    ;====================busco el otro usuario=================
    b3:
        mov al, users[di]
        inc di
        cmp al, 13
        je b1 
        cmp al, 36
        je b5
        jmp b3
    ;====================empiezo a desbloquear======================
    b4:
        inc di
        mov al, users[di]
        cmp al, 44
        je b41
        jmp b4
    b41: 
        inc di
        inc di
        inc di
        mov al, users[di]
        cmp al, 49 
        je desbl
        jne nb 
    desbl:
        mov users[di], 48
        ActualizarUsers
        print msgDescender2
        getChar
        limpiar
        jmp final
    nb:
        print msgDescender3
        getChar
        limpiar
        jmp final
    ;==============el usuario que ingreso no existe lo resgreso al menu
    b5:
        limpiar
        print msgNoExisteUser
        getChar
        limpiar
        jmp final
    final:
ENDM