rotate_shift_add_encrypt proc
    push    ebx
    mov     eax, [esp+4+arg_4]
    mov     edx, [eax]
    lea     ecx, [edx+edx]
    shr     edx, 0Fh
    or      edx, ecx
    movzx   ecx, dx
    mov     [eax], ecx
    add     ecx, [esp+4+arg_0]
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
    add     eax, 20h ; ' '
    pop     ebx
    retn
rotate_shift_add_encrypt endp

