%ifndef _SUMABC_ASM_ ; continue if _FACTORIAL_ASM_ is undefined
%define _SUMABC_ASM_ ; make sure that it is defined
                        ; otherwise, %include allows only one inclusion

;define the function
sumABC:
 mov eax,[esp+4]
 mov ebx,[esp+8]
 mov ecx,[esp+12]
 add eax,ebx
 add eax,ecx
 mov ecx,eax
 ret

%endif