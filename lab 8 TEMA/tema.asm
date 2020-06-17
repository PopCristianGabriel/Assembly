bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf
import printf msvcrt.dll                ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;ENUNT
    ;Two numbers a and b are given. Compute the expression value: (a-b)*k, where k is a constant value defined in data segment. Display the expression value (in base 16). 
    a resd 1
    b resd 1
    k db 7
    format  db "%d", 0
    message  db "Rezultatul expresiei (a-b)*k = %X", 0 
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword a       ; pushing the parameters on the stack from right to left
		push dword format
		call [scanf]       ; calling the scanf function for reading
		add esp, 4 * 2     ; cleaning the parameters from the stack
		; ...
         push dword b       ; pushing the parameters on the stack from right to left
		push dword format
		call [scanf]       ; calling the scanf function for reading
		add esp, 4 * 2     ; cleaning the parameters from the stack
		; ...
        mov eax,0
        mov al,[a]
        mov ebx,0
        mov bl,[b]
        sub al,bl
        mul byte [k]
        push eax
        push dword message
        call [printf]
        add esp, 4*2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
