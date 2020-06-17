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
    ;a,b,c - byte, d - word
    ;3*[20*(b-a+2)-10*c]+2*(d-3)
    
    a db 5
    b db 7
    c db 11
    d dw 9
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[a]
        mov bl,[b]
        sub bl,al ; b-a
        add bl,2 ; b-a+2
        
        
        
        mov al,20
        mul bl ; (b-a+2) * 20 si rezultatul il am in ax
        mov bx,ax ; (b-a+2)*20 e in bx
        
        
        
        mov al,[c]
        mov cl,10
        mul cl ;(10 * c) e in ax
        
    
        sub bx,ax ;20*(b-a+2)-10*c e in bx
        mov ax,3
        mul bx ; in dx:ax am 3*[20*(b-a+2)-10*c]
        push dx
        push ax ; in stiva am 3*[20*(b-a+2)-10*c]
        
        
        mov ax,[d]
        mov bx,3
        sub ax,bx ; in ax am d-3
        
        mov bx,2
        mul bx ; in dx:ax am 2*(d-3)
        
        
        pop ecx ; in eax am 3*[20*(b-a+2)-10*c]
        push dx
        push ax
        pop eax ;in eax am 2*(d-3)
        add eax,ecx ; in eax am rez
       
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
