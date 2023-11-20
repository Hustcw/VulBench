i2ulaw_array proc
    test    esi, esi
    jle     short locret_44B831
    mov     r8d, esi
    xor     ecx, ecx
    jmp     short loc_44B81D
loc_44B800:
    neg     esi
    sar     esi, 12h
    movsxd  rax, esi
    movzx   eax, ds:ulaw_encode[rax]
    and     al, 7Fh
loc_44B811:
    mov     [buffer+i], al
    add     i, 1
    cmp     r8, rcx
    jz      short locret_44B831
loc_44B81D:
    mov     esi, [ptr+i*4]
    test    esi, esi
    js      short loc_44B800
    shr     rsi, 12h
    movzx   eax, ds:ulaw_encode[rsi]
    jmp     short loc_44B811
locret_44B831:
    retn
i2ulaw_array endp

