bn_expand proc
    cmp     dword ptr [a+0Ch], 0
    jle     short loc_46196A
    mov     rax, a
    retn
loc_46196A:
    mov     esi, 1
    jmp     bn_expand2
bn_expand endp

