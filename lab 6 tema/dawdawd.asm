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
    a dw 7
    prim resd 1
; our code starts here
segment code use32 class=code

factorial:                  ; int _stdcall factorial(int n)
	mov eax, 1
	mov ecx, [esp + 4]  ; read the parameter from the stack

	repeat: 
		mul ecx
	loop repeat         ; the case ecx = 0 is not considered

	ret 
    start:
        ; ...
        push dword 5
        call factorial
      
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
