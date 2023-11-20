sub_80485FB proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     [ebp+var_10], 0
    jmp     short loc_804866E
loc_804860A:
    sub     esp, 0Ch
    push    90h; size
    call    _malloc
    add     esp, 10h
    mov     [ebp+dest], eax
    cmp     [ebp+var_10], 0
    jnz     short loc_8048631
    mov     eax, [ebp+dest]
    mov     ds:dword_8049FB8, eax
    mov     eax, [ebp+dest]
    mov     [ebp+var_C], eax
loc_8048631:
    mov     eax, [ebp+var_10]
    mov     edx, src[eax*4]
    mov     eax, [ebp+dest]
    sub     esp, 8
    push    edx; src
    push    eax; dest
    call    _strcpy
    add     esp, 10h
    mov     eax, [ebp+dest]
    mov     dword ptr [eax+8Ch], 0
    mov     eax, [ebp+var_C]
    mov     edx, [ebp+dest]
    mov     [eax+8Ch], edx
    mov     eax, [ebp+dest]
    mov     [ebp+var_C], eax
    add     [ebp+var_10], 1
loc_804866E:
    cmp     [ebp+var_10], 2
    jle     short loc_804860A
    mov     ds:dword_8049FB4, 3
    leave
    retn
sub_80485FB endp

