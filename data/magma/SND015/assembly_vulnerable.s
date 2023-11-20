i2alaw_array proc
    test    esi, esi
    jle     short locret_430A11
    mov     r8d, esi
    xor     ecx, ecx
    jmp     short loc_4309FD
loc_4309E0:
    neg     esi
    sar     esi, 14h
    movsxd  rax, esi
    movzx   eax, ds:alaw_encode[rax]
    and     al, 7Fh
loc_4309F1:
    mov     [buffer+i], al
    add     i, 1
    cmp     r8, rcx
    jz      short locret_430A11
loc_4309FD:
    mov     esi, [ptr+i*4]
    test    esi, esi
    js      short loc_4309E0
    shr     rsi, 14h
    movzx   eax, ds:alaw_encode[rsi]
    jmp     short loc_4309F1
locret_430A11:
    retn
i2alaw_array endp

