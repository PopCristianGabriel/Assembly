bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf,fopen,fclose,fprintf
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s dd 0
    message db "enter a string:",0
    stringFormat db "%s",0
    
    accesMode db "a",0
    fileName db "aici.txt",0
    fileDescriptor dd -1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        
        
        
        push dword accesMode
        push dword fileName
        call [fopen]
        add esp, 4*2
        
        mov [fileDescriptor],eax
        cmp eax,0
        je final
        
        bucla:
        push dword message
        call [printf]
        add esp, 4
        
        push dword s
        push dword stringFormat
        call [scanf]
        add esp,4*2
        
        cmp [s],dword "0"
        je final
        
        push dword s
        push dword [fileDescriptor]
        call [fprintf]
        add esp, 4*2
        
        
        jmp bucla
        
        final:
        push dword [fileDescriptor]
        call [fclose]
        add esp,4
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
