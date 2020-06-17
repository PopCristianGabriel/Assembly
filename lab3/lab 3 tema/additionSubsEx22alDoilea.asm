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
    ;a - byte, b - word, c - double word, d - qword - Signed representation
    ;c+b-(a-d+b) 
    a db 5
    b dw 9
    c dd 4
    d dq 8
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax,[b]
        cwd ; ax->dx:ax
        cwde; dx:ax->eax --in eax am b
        mov ecx,[c]
        add eax,ecx ; in eax am c+b
        push eax ; in stiva am c+b
        
        
        mov al,[a]
        cbw
        cwd
        cdq ; in edx:eax am a
        mov ebx,[d]
        mov ecx,[d+4] ; in ecx:ebx am d
        sub eax,ebx
        sbb edx,ecx ; in edx:eax am a-d
        mov ebx,eax
        mov ecx,edx ; in ecx:ebx am a-d
        
        
        mov ax,[b]
        cwd
        cwde
        cdq ; in edx:eax am b
        add ebx,eax
        adc ecx,edx ; in ecx:ebx am a-d+b
        pop eax
        cdq
        sub eax,ebx
        sbb edx,ecx;in edx:ecx am rezultatul
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
