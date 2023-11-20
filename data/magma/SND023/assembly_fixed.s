i2ulaw_array proc
    test    esi, esi
    jle     short locret_44B937
    mov     r9d, esi
    xor     ecx, ecx
    mov     r8d, 80000000h
    jmp     short loc_44B91C
loc_44B8F1:
    neg     esi
    sar     esi, 12h
    movsxd  rax, esi
    movzx   eax, ds:ulaw_encode[rax]
    and     al, 7Fh
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_44B910:
    mov     [buffer+i], al
    add     i, 1
    cmp     r9, rcx
    jz      short locret_44B937
loc_44B91C:
    mov     esi, [ptr+i*4]
    mov     al, 80h
    cmp     rsi, r8
    jz      short loc_44B910
    test    esi, esi
    js      short loc_44B8F1
    shr     rsi, 12h
    movzx   eax, ds:ulaw_encode[rsi]
    jmp     short loc_44B910
locret_44B937:
    retn
i2ulaw_array endp

