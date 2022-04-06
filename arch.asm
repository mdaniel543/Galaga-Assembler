AbrirArchivo MACRO arreglo,handler
	mov ah,3dh
	mov al,02h
	lea dx,arreglo
	int 21h
	jc Error
	mov handler,ax
ENDM

CerrarArchivo MACRO handler
Local Inicio,Final
	Inicio:
	mov ah,3eh
	mov bx,handler
	int 21h
	jc Error
	jmp Final

	Final:
ENDM

EscribirArchivo MACRO arreglo, handler
Local Inicio,Final
	Inicio:
	mov ah, 40h
	mov bx, handler
	mov cx, SIZEOF arreglo - 1
	lea dx, arreglo
	int 21h
	jc Error	
	Final:
ENDM


CrearArchivo MACRO arreglo,handler
Local Inicio,Final
	Inicio:
	mov ah,3ch
	mov cx,00h
	lea dx,arreglo
	int 21h
	jc Error
	mov handler,ax	
	jmp Final
	Final:
ENDM