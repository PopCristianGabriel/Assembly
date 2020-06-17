bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll 
import scanf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

                          
                          
%include "sumABC.asm"               
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    rez resd 1
    a resd 1
    b resd 1
    c resd 1
    format  db "%d", 0
    
    ;ENUNT
    ;Read the signed numbers a, b and c on type byte; calculate and display a+b+c. 
; our code starts here
segment code use32 class=code




    start:
        ; ...
        push dword a       ; pushing the parameters on the stack from right to left
		push dword format
		call [scanf]
        add esp, 4 * 2
        
        mov eax,[a]
         
        push dword b       ; pushing the parameters on the stack from right to left
		push dword format
		call [scanf]   
        add esp, 4 * 2
        segmentd'
        mov eax,[b]
        
        push dword c       ; pushing the parameters on the stack from right to left
		push dword format
		call [scanf]  
        add esp, 4 * 2
        
        mov eax,[c]
        
        push dword [a]
        push dword [b]
        push dword [c]
        
        
        call sumABC
        add esp,4*3
        mov [rez],ecx
        push dword [rez]
        push dword format
        call [printf]
        add esp,4
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
