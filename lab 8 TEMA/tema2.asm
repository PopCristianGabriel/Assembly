bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf,fopen, fclose ,fprintf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll

;ENUNT 
;A file name (defined in data segment) is given. Create a file with the given name, 
;then read words from the keyboard until character '$' is read. Write only the words that contain at least one uppercase letter to file. 


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
file_name db "eu.txt", 0
access_mode db "w", 0
file_descriptor dd -1

message db "Enter a word:",0
format db "%s"
spatiu db " ",0
index dd 0
ok dd 0
s resd 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack

        mov [file_descriptor], eax  ; store the file descriptor returned by fopen
       
        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final

        
       inceput:
       push dword message
       call[printf]
       add esp,4
       
       
       push dword s
       push dword format
       call[scanf]
       add esp,4*2
       mov esi,s
       
       lodsb
       cbw
       cwd
       mov ebx,"$"
       cmp ebx,eax
       je final
        
       mov [index],dword 0
       mov [ok],dword 0
       mov eax,0
       mov esi,s
       verificare:
       lodsb
       cmp al,0
       je decide
       cmp al,"A"
       jae cmp2
       
       
       jmp continua
       
       cmp2:
       cmp al, "Z"
       ja continua
       mov [ok], dword 1
       
       
       continua :
       inc dword [index]
       jmp verificare
       
       
       
       decide:
       cmp [ok],dword 0
       je inceput
       push dword s
       push dword [file_descriptor]
       call [fprintf]
       add esp, 4*2
       
       push dword spatiu
       push dword [file_descriptor]
       call [fprintf]
       add esp, 4*2
    
       jmp inceput
       
        final:
        ; exit(0)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4

        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
