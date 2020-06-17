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

    
    v db 12h,34h,56h,78h,01h,02h,03h,04h
    v1 dw 1234h,5678h,0102h,0304h
    v2 dd 12345678h,01020304h
    v4 dq 1234567801020304h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax,[v]
        mov eax,[v+1]
        mov eax,[v+2]
        
        mov eax,[v1]
        mov eax,[v1+1]
        mov eax,[v1+2]
        
        mov eax,[v2]
        mov eax,[v2+1]
        mov eax,[v2+2]
        
        mov eax,[v2]
        mov eax,[v2+1]
        mov eax,[v2+2]
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
