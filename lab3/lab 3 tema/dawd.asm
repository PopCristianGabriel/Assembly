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
    ;a - byte, b - word, c - double word, d - qword - UNSIGNED representation
    ;(d+c) - (c+b) - (b+a) 
    
    a db 5
    b dw 8
    c dd 10
    d dq 3
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[a]
        mov bx,[b]
        mov ah,0 ; in ax am a
        add ax,bx ; in ax am b+a
        mov cx,0 ; in cx:bx am b
        push cx
        push bx
        pop ebx
        mov ecx,[c]
        add ebx,ecx ; in ebx am c+b
        mov dx,0 ; in dx:ax am b+a
        push dx
        push ax
        pop eax ; in eax am b+a
        sub ebx,eax ; in ebx am (c+b) - (b+a)
        push ebx ; in stiva am (c+b) - (b+a)
        mov eax,[d]
        mov edx,[d+4] ; in edx:eax am d
        mov ecx,[c]
        add eax,ecx
        adc edx,0 ; in edx:eax am d+c
        pop ebx ; in ebx am (c+b) - (b+a)
        sub eax,ebx
        sbb edx,0 ; in edx:eax am rezultatul
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
