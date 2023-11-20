i2alaw_array proc
    test    esi, esi
    jle     short locret_430AE7
    mov     r9d, esi
    xor     ecx, ecx
    mov     r8d, 80000000h
    jmp     short loc_430ACC
loc_430AA1:
    neg     esi
    sar     esi, 14h
    movsxd  rax, esi
    movzx   eax, ds:alaw_encode[rax]
    and     al, 7Fh
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_430AC0:
    mov     [buffer+i], al
    add     i, 1
    cmp     r9, rcx
    jz      short locret_430AE7
loc_430ACC:
    mov     esi, [ptr+i*4]
    mov     al, 0AAh
    cmp     rsi, r8
    jz      short loc_430AC0
    test    esi, esi
    js      short loc_430AA1
    shr     rsi, 14h
    movzx   eax, ds:alaw_encode[rsi]
    jmp     short loc_430AC0
locret_430AE7:
    retn
i2alaw_array endp

