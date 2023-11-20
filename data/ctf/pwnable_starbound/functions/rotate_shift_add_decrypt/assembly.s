rotate_shift_add_decrypt proc
    push    ebx
    mov     edx, [esp+4+arg_4]
    mov     ecx, [edx]
    lea     eax, [ecx+ecx]
    shr     ecx, 0Fh
    or      ecx, eax
    movzx   eax, cx
    mov     [edx], eax
    mov     ecx, [esp+4+arg_0]
    sub     ecx, eax
    sub     ecx, 20h ; ' '
    mov     edx, 0AC769185h
    mov     eax, ecx
    imul    edx
    lea     eax, [edx+ecx]
    sar     eax, 6
    mov     ebx, ecx
    sar     ebx, 1Fh
    sub     eax, ebx
    imul    eax, 5Fh ; '_'
    sub     ecx, eax
    mov     eax, ecx
    lea     edx, [ecx+5Fh]
    test    ecx, ecx
    cmovs   eax, edx
    lea     edx, [eax+5Fh]
    cmp     eax, 1Fh
    cmovle  eax, edx
    pop     ebx
    retn
rotate_shift_add_decrypt endp

