INCLUDE arch.asm
INCLUDE user.asm
INCLUDE admin.asm
INCLUDE main.asm
INCLUDE scr.asm
INCLUDE ord.asm

.model small
.stack 
.data 
    encabezado db "Universidad de San Carlos de Guatemala",10, 13, "Facultad de Ingenieria",10, 13, "Escuela de Ciencias y Sistemas",10, 13, "Arquitectura de Compiladores y ensambladores 1",10, 13, "Seccion A", 10, 13, "Marvin Daniel Rodriguez Felix", 10, 13, "201709450", 10, 13, "$"
    menuP db 0ah, 0dh, 'MENU', 0ah, 0dh, '$'
    opciones db 0ah, 0dh, 'F1. Iniciar Sesion', 0ah, 0dh, 'F5. Registrar', 0ah, 0dh, 'F9. Salir', 0ah, 0dh, '$'
    salto db 10, 13, "$"
    var db 0, '$'
    msgErrorGeneral db 0ah,0dh,'Se ha cometido algun error de archivo','$'

    ;============ MENU PRINCIPAL =============

    msglogin db 0ah, 0dh, 'INICIAR SESION', 0ah, 0dh, '$'
    msgLine db '================================================', 0ah, 0dh, '$'
    msgRegister db 0ah, 0dh, 'REGISTRO', 0ah, 0dh, '$'
    
    msgUsername db 0ah, 0dh, 'Username: ', '$'  
    msgPassword db 0ah, 0dh, 'Password: ', '$'  

    bufferU db 30 dup('$'), '$'
    bufferP db 30 dup('$'), '$'

    contadorSI dw 0, '$'

    ArchivoInformacion db 250 dup('$')
    ArchivoRutaUsuarios db 'users.gal', 00h, '$'
    ArchivoHandler dw ?, '$'

    users db 1000 dup('$'),'$'

    msgNoExisteUser db 0ah, 0dh, '>>  El Usuario no esta registrado', 0ah, 0dh, '$'
    msgPassError db 0ah, 0dh, '>>  Password incorrecta', 0ah, 0dh, '$'

    msgAdminLogin db 0ah, 0dh, '>>  Bienvenido Admin General', 0ah, 0dh, '$'
    msgAdmin1 db 0ah, 0dh, '>>  Bienvenido Admin ', 0ah, 0dh, '$'
    msgLoginCorrecto db 0ah, 0dh, '>>  Bienvenido Usuario ', 0ah, 0dh, '$'

    msgUsuarioBloqueado db 0ah, 0dh, '>>  Usuario Bloqueado, Contacte con Administrador', 0ah, 0dh, '$'
    msg3intentos db 0ah, 0dh, '>>  Hubo 3 intentos fallidos', '$'
    
    msgAdminPassE db 0ah, 0dh, '>> Porfavor espere: ', '$'
    msgAdminPassE2 db 's e intente nuevamente', 0ah, 0dh,  '$'
    

    msgValidaciones db 0ah, 0dh, '>>                       Accion Rechazada                             <<', '$'
    msgValidacion   db 0ah, 0dh, '>>                                                                    <<', '$'
    msgRequisito    db 0ah, 0dh, '>> Requisitos olvidados:                                              <<', '$'

    msgVU1          db 0ah, 0dh, '>> No se puede empezar por numero el usuario                          <<', '$'
    msgVU2          db 0ah, 0dh, '>> El usuario tiene que tener entre 8 y 15 caracteres                 <<', '$'
    msgVU3          db 0ah, 0dh, '>> El usuario ya existe                                               <<', '$'
    msgVU4          db 0ah, 0dh, '>> El usuario solo puede contener (-)(_)(.) como caracter especial    <<', '$'

    msgP1           db 0ah, 0dh, '>> La contrasenia debe de tener al menos una mayuscula                <<', '$'
    msgP2           db 0ah, 0dh, '>> La contrasenia debe de tener al menos un numero                    <<', '$'
    msgP3           db 0ah, 0dh, '>> Se debe de tener al menos un caracter especial: (!)(>)(%)(;)(*)    <<', '$'
    msgP4           db 0ah, 0dh, '>> La contrasenia debe contener entre 16 y 20 caracteres              <<', '$'

    banderaU1 db 00h, '$'
    banderaU2 db 00h, '$'
    banderaU3 db 00h, '$'
    banderaU4 db 00h, '$'

    banderaP1 db 00h, '$'
    banderaP2 db 00h, '$'
    banderaP3 db 00h, '$'
    banderaP4 db 00h, '$'

    banderaG db 00h, '$'
    conteo db 0, '$'

    msgRegistroCorrecto db 0ah, 0dh, '>>    Usuario registado correctamente ', 0ah, 0dh, '$'

    intentos db 0, '$'
    guardarDI dw 0, '$'
    temp db 0, '$'

    ;=================== MENU USUARIO ===============
    msgUsermenu db 0ah, 0dh, 'MENU DE USUARIO      USER: ', '$'
    msgOpcionesUser db 0ah, 0dh, 'F2. Jugar ', 0ah, 0dh, 'F3. Mostrar el marcador de los 10 primeros', 0ah, 0dh, 'F5. Mostrar mi marcador de los 10 primeros', 0ah, 0dh, 'F9. Cerrar Sesion', 0ah, 0dh, '$'  

    ;====================MENU ADMIN===================

    msgAdminMenu db 0ah, 0dh, 'MENU ADMINISTRADOR      USER: ', '$'
    msgOpcionesAG db 0ah, 0dh, 'F1. Debloquear Usuario ', 0ah, 0dh, 'F2. Ascender usuario a admin', 0ah, 0dh, 'F3. Descender admin a usuario', 0ah, 0dh, 'F5. Ordenamiento de burbuja', 0ah, 0dh, 'F6. Ordenamiento por monticulos', 0ah, 0dh, 'F7. TimSort', 0ah, 0dh, 'F9. Cerrar Sesion', 0ah, 0dh, '$'  
    msgOpcionesA db 0ah, 0dh, 'F1. Debloquear Usuario ', 0ah, 0dh, 'F2. Mostrar el marcador de los 10 primeros', 0ah, 0dh, 'F3. Mostrar mi marcador de los 10 primeros', 0ah, 0dh, 'F4. Jugar', 0ah, 0dh, 'F5. Ordenamiento de burbuja', 0ah, 0dh, 'F6. Ordenamiento por monticulos', 0ah, 0dh, 'F7. TimSort', 0ah, 0dh, 'F9. Cerrar Sesion', 0ah, 0dh, '$'  

    msgCerrarSession db 0ah, 0dh, '>> Sesion Cerrada con exito.... ', 0ah, 0dh, '$'


    msgAdminUnlock db 0ah, 0dh, 'Desbloquear Usuario    USER: ', '$'
    msgUnlock db 0ah, 0dh, 'Usuario a desbloquear: ', '$'
    
    msgUnlock1 db 0ah, 0dh, '>> Usuario desbloqueado correctamente        <<', '$'
    msgUnlock2 db 0ah, 0dh, '>> ERROR, El Usuario no estaba bloqueado     <<', '$'

    bufferUnlock db 30 dup('$'), '$'
    bufferBan db 30 dup('$'), '$'

    msgAscender  db 0ah, 0dh, 'Ascender a Admin    USER: ', '$'
    msgAscender1 db 0ah, 0dh, 'Usuario para Ascender: ', '$'
    
    msgAscender2 db 0ah, 0dh, '>> Usuario Ascendido correctamente           <<', '$'
    msgAscender3 db 0ah, 0dh, '>> ERROR, El Usuario ya es Admin             <<', '$'

    msgDescender  db 0ah, 0dh, 'Descender a Usuario    USER: ', '$'
    msgDescender1 db 0ah, 0dh, 'Usuario a descender: ', '$'
    
    msgDescender2 db 0ah, 0dh, '>> Usuario Desendido correctamente           <<', '$'
    msgDescender3 db 0ah, 0dh, '>> ERROR, El Usuario no es Admin             <<', '$'

    cont db 0, '$'
    resultado db 5 dup('$')

    ;=================JUEGO===============
    msgjuego1 db '-Usuario:', '$'
    msgjuego2 db '-Nivel:', '$'
    msgjuego3 db '-Punteo:', '$'
    msgjuego4 db '-Tiempo:', '$'
    msgjuego5 db '-Vidas:', '$'


    level db 49, '$'
    score db 48,48,48, '$'
    time db 48,48,58,48,48,58,48,48, '$'
    lives dw 3, '$'

    auxcora  dw 0, '$'
    auxcoro1 dw 0, '$'
    auxcoro2 dw 0, '$'

    contador1 dw 0, '$'
    contador2 dw 0, '$'

    auxnave dw 0, '$'
    auxnave2 dw 0, '$'
    contador3 dw 0, '$'
    contador4 dw 0, '$'
    contador5 dw 0, '$'
    
    nx dw 0, '$'
    ny dw 0, '$'
    
    cIzqx dw 0, '$'
    cIzqy dw 0, '$'
    cCenx dw 0, '$'
    cCeny dw 0, '$'
    cDerx dw 0, '$'
    cDery dw 0, '$'

    contaux dw 0, '$'
    contaux1 dw 0, '$'
    contaux2 dw 0, '$'
    oaux dw 0, '$'
    oaux2 dw 0, '$'
    oaux3 dw 0, '$'

    banderaTerminaJuego db 00h, '$'

    msg_esc1   db 'Esc Pausa', '$'
    msg_esc2   db 'Esc Salir', '$'
    msg_start1 db 'Spa Empieza', '$'
    limpia1    db '            ', '$'
    msg_start2 db 'Spa Continua', '$'
    finjuego   db 'Fin Juego', '$'

    enemigos db 126 dup('$'), '$'

    posicion db 126 dup('$'), '$'

    otravez dw 0, '$'

    cote1 dw 0, '$'
    cote2 dw 0, '$'

    suplente dw 0, '$'
    siaux dw 0, '$'

    balas db 9 dup('$'), '$'

    auxbala dw 0, '$'
    auxbala1 dw 0, '$'
    auxbala2 dw 0, '$'

    ab dw 0, '$'
    auxcolision  dw 0, '$'
    auxcolision2 dw 0, '$'

    decsuma dw 0, '$'

    auxvida dw 0, '$'
    templlenado db 0, '$'
    retardo dw 0, '$'

    ;==================reporte scores==================
    ArchivoRutaScore db 'scores.gal', 00h, '$'
    ArchivoHandlerScore dw ?, '$'
    scores db 1000 dup('$'),'$'
    scoresOrdenados db 1000 dup('$'),'$'

    msgMarcador1 db 0ah, 0dh, 'Top 10 Marcador                         USER: ', '$'
    msgLine2     db           '=============================================================', 0ah, 0dh, '$'
    msgMarcador11 db 0ah, 0dh, 'Mi Top 10 Marcador                     USER: ', '$'
    msgMarcador2 db 0ah, 0dh, 'Rango     Jugador             N    Puntos      Tiempo ', 0ah, 0dh, '$'
    
    msgline_     db 0ah, 0dh, '_____________________________________________________________', 0ah, 0dh, '$'

    msgenterCo   db 0ah, 0dh, '>>             PRESIONA ENTER PARA VOLVER A MENU           <<', 0ah, 0dh, '$'

    auxaux db 50 dup('$'), '$'

    i db 0, '$'
    j db 0, '$'

    conteo_scores dw 0, '$'
    cont_caracteres dw 0 ,'$'

    conteo_auxiliar dw 0, '$'
    guardar_inicio_i dw 0, '$'
    guardar_inicio_j dw 0, '$'

    uaxb  db 0,0,0, '$'
    auxw  dw 0, '$'
    auxwi dw 0, '$'
    auxwj dw 0, '$'

    sd db 0, '$'
    caracterP db 0, '$'
    rank db 48, '$'
    sangria1 db 32,32,32,32,32,32,32,32,32, '$'
    sangria2 db 32,32,32,32,32, '$'

    ;================ordenamientos===============
    msg01 db 0ah, 0dh, 'Ordenamiento de burbuja               USER:', '$'
    msg02 db 0ah, 0dh, 'Ordenamiento por monticulos           USER:', '$'
    msg03 db 0ah, 0dh, 'TimSort                               USER:', '$'  


    msgsubMenu  db 0ah, 0dh, 'F1. Ascendente', 0ah, 0dh, 'F2. Descendente', 0ah, 0dh, 'F9. Regresar', 0ah, 0dh, '$'

    msgSubMenu2 db 0ah, 0dh, 'F1. Puntos', 0ah, 0dh, 'F2. Tiempo', 0ah, 0dh, 'F9. Regresar', 0ah, 0dh, '$'

    msgSubMenu3 db 0ah, 0dh, 'F1. 0', 0ah, 0dh, 'F2. 1', 0ah, 0dh, 'F3. 2', 0ah, 0dh,'F4. 3', 0ah, 0dh,'F5. 4', 0ah, 0dh,'F6. 5', 0ah, 0dh,'F7. 6', 0ah, 0dh,'F8. 7', 0ah, 0dh, 'F9. Regresar', 0ah, 0dh, '$'

    banderaPuntos db 00h, '$'
    banderaTiempo db 00h, '$'
    banderaAscendente db 00h, '$'
    banderaDescendente db 00h, '$'

    velocidad dw 0, '$'
    veloci db 0, '$'

    punteos db 100 dup('$'), '$'
    tiempos dw 55 dup('$'), '$'
    temporall db 0,0,0, '$'
    temporatt dw ?, '$'

    obtengo dw 48,48,48, '$'
    obte db 0, '$'
    pe db 0, '$'

    teste db 10 dup('$'), '$'
    auxiliar_burbuja1 db 0, '$'
    auxiliar_burbuja2 db 0, '$'

    buble db 'Burbuja', '$'
    vel db 'Velocidad:', '$'
    pun db 'Punteo', '$'
    home db 'Presionar HOME para iniciar', '$'

    posicion_grafica db 0, '$'
    posicion_pixeles dw 0, '$'
    posicio_div db 0, '$'
    posicion_final dw 0, '$'

    banderaTerminaOrdenamiento db 00h, '$'

.code 

;description
main PROC
    Inicio:
        limpiar
        print encabezado
        getChar
        cmp al, 13
        je Menu
        jmp Inicio
    Menu:
        UserGal
        print menuP
        print msgLine
        print opciones
        getTecla
        cmp ah, 3Bh
        je Login
        cmp ah, 3Fh
        je Register
        cmp ah, 43h
        je Exit
        jmp Menu
    Login:
        limpiar
        print msglogin
        print msgLine
        Credenciales 00h
        ComprobarUsuario 
        jmp Menu
    Register:
        limpiar
        print msgRegister
        print msgLine
        Credenciales 00h
        ValidacionUsuario
        jmp Menu
    Error:
		print salto
		print msgErrorGeneral
		getChar
    Exit:
        mov ah, 4ch
		xor al,al
		int 21h
        		
main ENDP

DS_DATOS proc
    push ax
    mov ax, @data
    mov ds,ax
    pop ax
    ret
DS_DATOS endp

DS_VIDEO proc
    push ax
    mov ax, 0A000h
    mov ds, ax
    pop ax
    ret
DS_VIDEO endp

EmpiezaJuego_proc proc
    EmpiezaJuego
    ret
EmpiezaJuego_proc endp

Inicia_Juego proc
    Inicio_Tiempo
    ret
Inicia_Juego endp

Inicio_Nivel1_proc proc
    Inicio_Nivel1
    ret
Inicio_Nivel1_proc endp

Inicio_Nivel2_proc proc
    Inicio_Nivel2
    ret
Inicio_Nivel2_proc endp

Inicio_Nivel3_proc proc
    Inicio_Nivel3
    ret
Inicio_Nivel3_proc endp

mover_proc proc
    Mover
    ret
mover_proc endp

DatosMostrados_proc proc
    DatosMostrados 
    ret
DatosMostrados_proc endp

ModoGraficoOrdenamiento_proc proc
    ModoGraficoOrdenamiento
    ret
ModoGraficoOrdenamiento_proc endp

end main 