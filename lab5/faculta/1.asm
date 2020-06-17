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
    a db '3' , '5', '7' ,'2'
    lengthA equ $ - a
    b db '9' , '0' , '1' , '1', '7'
    lengthB equ $ - b
    rez times (lengthA+lengthB) db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
    xor ecx,ecx
    mov ecx,lengthB
    jecxz sfarsit
    mov esi,lengthB-1
    mov edi,0
    Repeta:
        mov al,[b+esi]
        mov [rez+edi],al
        dec esi
        inc edi
    loop Repeta
    
    mov ecx,lengthA
    jecxz sfarsit
    mov esi,lengthA-1
    Repeta2:
        mov al,[a+esi]
        mov [rez+edi],al
        dec esi
        inc edi
    loop Repeta2
    
    sfarsit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
