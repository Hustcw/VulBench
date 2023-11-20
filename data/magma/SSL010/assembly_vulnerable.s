bn_expand proc
    mov     eax, esi
    add     eax, 3Fh ; '?'
    sar     eax, 1Fh
    shr     eax, 1Ah
    lea     esi, [bits+rax]
    add     esi, 3Fh ; '?'
    sar     esi, 6; words
    cmp     esi, [a+0Ch]
    jle     short loc_4434EE
    jmp     bn_expand2
loc_4434EE:
    mov     rax, a
    retn
bn_expand endp

