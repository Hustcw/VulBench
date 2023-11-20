d2ulaw_array proc
    push    r15
    push    r14
    push    r12
    push    rbx
    sub     rsp, 18h
    movsd   [rsp+38h+var_30], xmm0
    test    esi, esi
    jle     short loc_44B94F
    mov     r14, buffer
    mov     r15, ptr
    mov     r12d, esi
    xor     ebx, ebx
    jmp     short loc_44B91C
loc_44B900:
    cdqe
    mov     ecx, offset ulaw_encode
    sub     rcx, rax
    movzx   eax, byte ptr [rcx]
    and     al, 7Fh
loc_44B90F:
    mov     [buffer+i], al
    add     i, 1
    cmp     count, rbx
    jz      short loc_44B94F
loc_44B91C:
    movsd   xmm0, qword ptr [ptr+i*8]
    movsd   [rsp+38h+var_28], xmm0
    mulsd   xmm0, [rsp+38h+var_30]
    call    psf_lrint_15
    movsd   xmm0, [rsp+38h+var_28]
    ucomisd xmm0, ds:qword_470D18
    jb      short loc_44B900
    cdqe
    movzx   eax, ds:ulaw_encode[rax]
    jmp     short loc_44B90F
loc_44B94F:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    retn
d2ulaw_array endp

