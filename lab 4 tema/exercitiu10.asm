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
    ;Replace the bits 0-3 of the byte B by the bits 8-11 of the word A. 
    a dw 1001011011011011b
    b db 01011010b
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[a+1]
        and al,00001111b
        mov bl,[b]
        mov cl,4
        shr bl,cl
        mov cl,4
        shl bl,cl
        or bl,al
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
