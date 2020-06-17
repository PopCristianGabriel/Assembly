bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf,fopen,fclose,fread               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    fileDescriptor dd -1       ; variable to hold the file descriptor
    len equ 100                 ; maximum number of characters to read
    text times (len+1) dd 0  
    intrebare db "enter a file name:",0
    fileName dd 0
    fileNameFormat db "%s",0
    accesMode db "r",0
    cuvant resd 3
    salvare resd 1
    index dw 0
    formatPrintare db"%s",0
    formatPrintare2 db"%s ",0
    litera db 0
    spatiu db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov byte [spatiu], " "
        push dword intrebare
        call [printf]
        add esp,4*1
        
        
        
        push dword fileName
        push dword fileNameFormat
        call [scanf]
        add esp,4*2
        
        mov eax,[fileName]
        
        
        
        push dword accesMode
        push dword fileName
        call [fopen]
        add esp,4*2
        
        
        cmp eax,0
        je final
        mov [fileDescriptor],eax
        
        
        push dword [fileDescriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp,4*4
        
        mov esi,text
        mov edi,cuvant + 1
        mov dword [cuvant],0
        
        bucla:
        cld
        mov word[index],0
        lodsb
        cmp al,"$"
        je final
        cmp al,"."
        je inversare
        cmp al," "
        je reset
        stosb
        jmp bucla
        
        
        reset:
        mov edi,cuvant+1
        jmp bucla
        
        inversare:
        mov [salvare],esi
       
        mov esi,edi
        xor eax ,eax
        std
        lodsb
        jmp inversare2
        
        inversare2:
        std
        inc word [index]
        
        
        lodsb
        cmp eax,0
        je terminare
        
        mov [litera],eax
        push dword litera
        push dword formatPrintare
        call[printf]
        add esp,4*2
        jmp inversare2
        
        
        terminare:
        mov esi,[salvare]
        
        push dword spatiu
        push dword formatPrintare2
        call [printf]
        add esp,4*2
        jmp bucla
        
        
        
        
        final:
        push dword [fileDescriptor]
        call [fclose]
        add esp,4
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
