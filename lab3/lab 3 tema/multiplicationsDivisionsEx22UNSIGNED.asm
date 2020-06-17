bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;(a*b-2*c*d)/(c-e)+x/a
    ; a,b,c,d-byte; e-word; x-qword
    a db 3
    b db 6
    c db 7
    d db 5
    e dw 10
    x dq 33
    
    ;UNSIGNED REPRESENTATION
; our code starts here
segment code use32 class=code
    start:
        ; ...
       mov al,[a]
       mov bl,[b]
       imul bl; in ax am a*b
       mov cx,ax;in cx am a*b
       
       
       mov al,[c]
       mov bl,[d]
       imul bl ; in ax am c*d
       mov bx,2
       imul bx ; in dx:ax am 2*c*d
       push dx
       push ax
       pop ebx ;in eax am 2*c*d
       
       
       mov ax,cx ; in ax am a*b
       cwd ; in dx:ax am a*b
       cwde ; in eax am a*b
       sub eax,ebx ; in eax am a*b-2*c*d
       push eax ; l-am pus in stiva
       
       mov al,[c]
       cbw ; in ax am c
       mov bx,[e]
       sub ax,bx ; in ax am c-e
       mov bx,ax
       
       
       pop eax
       idiv word bx ; in dx am restul si in ax am catul lui (a*b-2*c*d)/(c-e)
       mov cx,ax ; acum e in cx
       
       mov al,[a]
       cbw
       cwd
       cwde ; in eax am a 
       mov ebx,eax
       mov eax ,[x]
       mov edx,[x+4] ; in edx:eax am x
       idiv dword ebx ; in eax am catul si in edx am restul lui x/a
       push eax ; catul e in stiva
       
       
       mov cx,ax; (a*b-2*c*d)/(c-e) e in ax
       cwd ; (a*b-2*c*d)/(c-e) e in dx:ax
       cwde; (a*b-2*c*d)/(c-e) e in eax
       
       
       pop ebx ;x/a
       sub ebx,eax ;rezultatul e in ebx
       
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
