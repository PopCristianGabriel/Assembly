bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    ;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the elements of A in reverse order. 
;Example:
;A: 2, 1, -3, 0
;B: 4, 5, 7, 6, 2, 1
;R: 1, 2, 6, 7, 5, 4, 0, -3, 1, 2


    ; ...
    a db '3' , '5', '7' ,'2'
    lengthA equ $ - a
    b db '9' , '0' , '1' , "11", '7'
    lengthB equ $ - b
    rez times (lengthA+lengthB) db 0
        
; our code starts here
segment code use32 class=code
    start:
        ; ...
    xor ecx,ecx 
    mov ecx,lengthB ; se stocheaza in ecx lungimea sirului b
    jecxz sfarsit ; daca nu exista lungime, se salta la final
    mov esi,lengthB-1  ;ne plasam la finalul sirului b
    mov edi,0
    
    
    
    Repeta:
        mov al,[b+esi] ; in al se pune ultimul caracter al sirului b
        mov [rez+edi],al ; la inceputul sirului rezultat se pune al
        dec esi ; se decrementeaza esi
        inc edi ; se incrementeaza edi
    loop Repeta
    
    ;LA FEL PT SIURL A
    
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
