bits 32

global _asmDouble
segment data public data use32
segment code public code use32

_asmDouble:
push ebp
mov ebp,esp
mov eax,[ebp+8]
add eax,eax
pop ebp
ret
