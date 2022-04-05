INCLUDE mcr1.asm

.model small 
.stack 
.data 
    encabezado db "Universidad de San Carlos de Guatemala",10, 13, "Facultad de Ingenieria",10, 13, "Escuela de Ciencias y Sistemas",10, 13, "Arquitectura de Compiladores y ensambladores 1",10, 13, "Seccion A", 10, 13, "Marvin Daniel Rodriguez Felix", 10, 13, "201709450", 10, 13, "$"
    opciones db '      MENU', 0ah, 0dh, 'F1. Login', 0ah, 0dh, 'F5. Register', 0ah, 0dh, 'F9. Exit', 0ah, 0dh, '$'
    salto db 10, 13, "$"
    var db 0, '$'

    msglogin db 0ah, 0dh, 'LOGIN', 0ah, 0dh, '$'
    msgLine db '=========================================', 0ah, 0dh, '$'
    msgRegister db 0ah, 0dh, 'REGISTER', 0ah, 0dh, '$'
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
        jmp Exit
    Register:
        print msgRegister
        print msgLine
        jmp Exit
    Exit:
        mov ah, 4ch
		xor al,al
		int 21h
        		
main ENDP

end main 