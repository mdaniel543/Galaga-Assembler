INCLUDE mcr1.asm
INCLUDE arch.asm
INCLUDE user.asm
INCLUDE admin.asm
INCLUDE main.asm

.model small 
.stack 
.data 
    encabezado db "Universidad de San Carlos de Guatemala",10, 13, "Facultad de Ingenieria",10, 13, "Escuela de Ciencias y Sistemas",10, 13, "Arquitectura de Compiladores y ensambladores 1",10, 13, "Seccion A", 10, 13, "Marvin Daniel Rodriguez Felix", 10, 13, "201709450", 10, 13, "$"
    opciones db 0ah, 0dh, '      MENU', 0ah, 0dh, 'F1. Login', 0ah, 0dh, 'F5. Register', 0ah, 0dh, 'F9. Exit', 0ah, 0dh, '$'
    salto db 10, 13, "$"
    var db 0, '$'
    msgErrorGeneral db 0ah,0dh,'Se ha cometido algun error de archivo','$'

    ;============ MENU PRINCIPAL =============

    msglogin db 0ah, 0dh, 'LOGIN', 0ah, 0dh, '$'
    msgLine db '=========================================', 0ah, 0dh, '$'
    msgRegister db 0ah, 0dh, 'REGISTER', 0ah, 0dh, '$'
    
    msgUsername db 0ah, 0dh, 'Username: ', '$'  
    msgPassword db 0ah, 0dh, 'Password: ', '$'  

    bufferU db 30 dup('$')
    bufferP db 30 dup('$')

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
    
    msgAdminPassE db 0ah, 0dh, '>> Porfavor espere: 30s', '$'
    msgAdminPassE2 db ' e intente nuevamente', 0ah, 0dh,  '$'
    

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
        print msglogin
        print msgLine
        Credenciales 00h
        ComprobarUsuario 
        jmp Menu
    Register:
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

end main 