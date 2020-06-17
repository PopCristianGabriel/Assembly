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
;Se dau doua siruri de octeti S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor din sirul S1 1uate de la stanga spre dreapta si a elementelor din sirul S2 luate de la dreapta spre stanga. 
;Exemplu:
;S1: 1, 2, 3, 4
;S2: 5, 6, 7
;D: 1, 2, 3, 4, 7, 6, 5

 s1 db 1 , 2 , 3 , 4
 lungS1 equ $-s1
 s2 db 5 , 6 ,7
 lungS2 equ $-s2
 d times (lungS1 + lungS2) db 0
 
; our code starts here
segment code use32 class=code
    start:
    
    mov ecx, lungS1
    cld
    mov esi, s1
    mov edi, d
    
    repeta:
    movsb
    loop repeta
    
    mov ecx, lungS2
    mov esi, s2 + lungS2 - 1
    repeta2:
    std
    lodsb
    cld
    stosb
    loop repeta2
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
