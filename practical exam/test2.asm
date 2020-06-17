bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fread,fprintf,fclose,printf,fopen         ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fread msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    fileDescriptior dd -1
    fileName db "aici2.txt",0
    accesModeRead db "r",0
    accesModeAppend db "a",0
    buffer dd 1
    format db "the number read is:%d",0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword accesModeRead
        push dword fileName
        call [fopen]
        add esp,4*2
        
        cmp eax,0
        je final2
        
        mov [fileDescriptior],eax
        
        bucla:
        
        push dword [fileDescriptior]
        push dword 1
        push dword 1
        push dword buffer
        call [fread]
        add esp, 4*4
        
        cmp eax,0
        je final
        xor edx,edx
        mov dl,[buffer]
        sub dl,"0"
        mov [buffer],dl
        mov dl,[buffer]
        
        push dword [buffer]
        push dword format
        call [printf]
        add esp,4*2
        
        jmp bucla
        
        
        final:
        push dword [fileDescriptior]
        call [fclose]
        
        
        
        final2:
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
