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
    ;a,b,c,d-byte, e,f,g,h-word
    ;(2*d+e)/a 
    a db 5
    e dw 10
    d db 7
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[d]
        mov bl,2
        mul bl ; in ax am 2*d
        mov bx,[e]
        add ax,bx ;in ax am 2*d+e
        mov bl,[a]
        div byte bl ; in al am catul si in ah restul rezultatului
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
