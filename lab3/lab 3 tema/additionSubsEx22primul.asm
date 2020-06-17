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
        mov dx,0 ; in dx:ax am b+a
        push dx
        push ax; in stiva am b+a
        pop ecx ; in ecx am b+a
        
        
        mov ax,[b]
        mov dx,0 ; in dx:ax am b
        push dx
        push ax
        pop eax
        mov ebx,[c]
        add eax,ebx ; in ebx am c+b
        sub eax,ecx;in eax am (c+b) - (b+a)
        push eax
        
        
        mov ebx,[d]
        mov ecx,[d+4]
        mov eax,[c]
        mov edx,0
        add eax,ebx
        adc edx,ecx ; in edx:eax am d+c
        pop ebx
        sub eax,ebx
        sbb edx,0 ; rezultatul il am in edx:eax
        
        

        
        
       
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
