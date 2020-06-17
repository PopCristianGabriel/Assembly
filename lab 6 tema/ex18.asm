bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

                          
;A string of doublewords is given. Order in increasing order the string of the high words (most significant) from these doublewords. The low words (least significant) remain unchanged. 
;Example:
;being given 
;sir DD 12AB5678h, 1256ABCDh, 12344344h 
;the result will be 
;       12345678h, 1256ABCDh, 12AB4344h.
                          
; our data is declared here (the variables needed by our program)


segment data use32 class=data
    ; ...
    ;       dx   bx   high low
    sir dd 12AB5678h, 1256ABCDh, 12344344h
    lungimeSir equ $-sir
    rez times lungimeSir dd 0
    doubleA dd 0
    
    doubleWordConstant db 4
    index dd 0
    ok resb 1
    
    patru dd 4
    
    highWord resw 1
    lowWord resw 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov ecx,lungimeSir
        cld
       inceput:
       
       mov [ok],byte 1
       mov esi,sir
       
       ;1234 5678h, 1256 ABCDh
       mov ecx,[index]
       
       jecxz jumpOver
       repeat:

       add esi,patru
       
       loop repeat
       
       jumpOver:
       
       
       lodsd
       mov [doubleA],eax
       mov bx,[doubleA];in bx am primul lowWord ->5678
       mov dx,[doubleA+2]; in dx am primul highword->1234
       mov [lowWord],bx ; in lowWord am primul lowWord
       mov [highWord],dx ; in highWord am primul highWord
      
       
       lodsd
       mov [doubleA],eax ; in eax am al doilea double word
       mov bx,[doubleA]  ; in bx am al doilea low Word->ABCD
       mov dx,[doubleA+2]  ; in dx am al doilea High Word->1256
       
       
       cmp  [highWord],dx
       ja schimba
       
       ;                    high  low   dx   bx
       ;sir dd 12AB 5678h, 1256 ABCDh, 1234 4344h
       
       jmp sari_peste_schimbare
       
       schimba:
       push word[highWord]
       push bx
       pop edx ; in edx am numarul mai mare
       push dx
       push word [lowWord]
       pop ebx ; in ebx am numarul mai  mic
       mov esi, index
       mov [sir+esi*4],ebx
       mov [sir+(esi+1)*4],edx
       mov [ok],byte 0
       
       sari_peste_schimbare:
       
       mov ecx,dword 4
       repeat2:
       inc dword [index]
       loop repeat2
       
       mov bl,lungimeSir
       cmp [index],bl  ; daca indexul a ajuns la final
       je verificaSir   ; verifica daca sirul este ordonat crescator in verificaSir
       jmp inceput
       
       
       
       
       verificaSir:
       cmp [ok],byte 1 ; daca sirul e ordonat crescator
       je termina      ;termina
       mov [index],byte 0 ; daca nu, incepem de la inceput cu indexul 0
       jmp inceput
       
       
       termina:
       
       sari_peste:
       
        
        ; exit(0)
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
