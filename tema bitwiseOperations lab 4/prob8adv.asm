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
    a dw 1001101100110110b
    b dw 0011010100110010b
    c resb 1
    masca dw 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
    ;Given the words A and B, compute the byte C as follows: 
    ;the bits 0-5 are the same as the bits 5-10 of A
   ; the bits 6-7 are the same as the bits 1-2 of B.
   ; Compute the doubleword D as follows: 
   ; the bits 8-15 are the same as the bits of C
   ; the bits 0-7 are the same as the bits 8-15 of B
   ; the bits 24-31 are the same as the bits 0-7 of A
   ; the bits 16-23 are the same as the bits 8-15 of A.
   
   
   ;;;;;;;;;;;;;;;;;;;; isolate the bits 5-10 of a and move them at the position 0-5
   mov ax ,[a]
   mov cl, 5
   shr ax,cl
   and ax,0000000000111111b
   mov [masca],ax
   mov bl,[masca]
   ;;;;;;;;;;;;;;;;;;; 
   mov dl,0
   or dl,al ; the result will be stored in dx
   ;;;;;;;;;;;;;;;;;;; the the bits 0-5 of C are now the bits 5-10 of A
   
   ;;;;;;;;;;;;;;;;;;;
   mov al,[b] ;put the first byte of b in al
   mov cl,5
   shl al,cl ; shift the bits 1-2 to position 6-7
   and al,11000000b ; isolate them
   or dl,al ; put them in dl
   ;;;;;;;;;;;;;;;;;; the byte C has been computed and it is stored in dl
   mov [c],dl
   mov al,dl
   cbw
   cwd
   cwde
   
   
   mov edx,eax
   mov cl,8
   shl edx,cl
   mov al,0
   mov al,[b+1]
   push edx
   cbw
   cwd
   cwde ; in eax am bitii 8-15 ai lui b
   pop edx
   or edx,eax
   
   
  
   mov al,0
   mov al,[a]
   push edx
   cbw
   cwd
   cwde; in eax am bitii 0-7 ai lui a
   mov cl,23 ;ii pun pe pozitia 24-31
   shl eax,cl
   pop edx
   or edx,eax
   
   mov al,0
   mov al,[a+1]
   push edx
   cbw
   cwd
   cwde
   mov cl,16
   shl eax,cl
   pop edx
   or edx,eax
   
   
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
