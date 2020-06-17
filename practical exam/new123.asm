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
   ; An array of words is given. Write an asm program in order to obtain an array of doublewords, where each doubleword will contain each nibble unpacked on a byte (each nibble will be preceded by a 0 digit), arranged in an ascending order within the doubleword. 
;Example:
;for the initial array: 
;1432h, 8675h, 0ADBCh, ...
;The following should be obtained: 
;01020304h, 05060708h, 0A0B0C0Dh, ...
    s dw 1432h, 8675h, 0ADBCh
    len equ ($-s) / 2
    rez times len dd 0
    lowByte resb 1
    highByte resb 1
    nr resb 1
    byte1 resb 1
    var1 db 1
    var2 db 1
    index db 0
    ok db 0
    sirBiti times 4 db 0
; our code starts here
segment code use32 class=code
    despica:
    mov [nr],  byte 0
    mov bl,[esp+4]
    mov bh, [esp+5]
    mov [var1],bl
    mov [var2],bh
    
   
   
    mov [byte1],bl
    inceput:
   
   
    and [byte1],byte 00001111b
    mov dl,[byte1]
    mov [lowByte],dl
    mov [byte1],bl
    and [byte1],byte 11110000b
    mov dl,[byte1]
    mov [highByte],dl
 
 
    mov cl,4
    shr byte [highByte],byte cl
    mov bl,[lowByte]
    mov bh,[highByte]
    cmp  bl, bh
    ja schimba
    jmp final
    
    
    
    schimba:
    mov dl,[lowByte]
    mov dh,[highByte]
    mov [lowByte],dh
    mov [highByte],dl
    
    
    final:
    mov bl, [lowByte]
    mov bh,0
    mov dl,[highByte]
    mov dh,0
    push word bx
    push word dx
    inc byte [nr]
    mov bl,[var2]
    mov [byte1],bl
    cmp byte [nr],1
    je inceput
    pop ebx
    pop ecx
    ret
    
    
    
 rearanjare:
    mov ah,[esp+4]
    mov al,[esp+6]
    mov bh,[esp+8]
    mov bl,[esp+10]
    mov edi, sirBiti
    cld
    stosb
    mov al,ah
    stosb
    mov al,bh
    stosb
    mov al,bl
    stosb
    mov [nr],byte 3
    mov esi,sirBiti
    mov ebx,0
    ordonare:
    mov [ok],byte 1
    incepe:
    mov dl,[esi + ebx]
    mov dh,[esi + ebx + 1]
    cmp dl,dh
    ja schimbare
    
    jmp incrementare
    
    schimbare:
    mov [esi+ebx],dh
    mov [esi+ebx+1],dl
    mov [ok],byte 0
    
    
    incrementare:
    inc dword ebx
    cmp ebx,dword 3
    je reset
    jmp Final
    
    
    reset:
    mov ebx,dword 0
    je Final
    jmp incepe
    
    Final:
    cmp [ok], byte 0
    je ordonare
    ret

    start:
        ; ...
        mov esi ,s
        mov edi, rez
        mov eax,0
        lodsw
        push eax
        call despica
        push ebx
        push ecx
        call rearanjare
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
