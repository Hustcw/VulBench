d2ulaw_array proc
    push    r15
    push    r14
    push    r12
    push    rbx
    sub     rsp, 28h
    movsd   [rsp+48h+var_40], xmm0
    test    esi, esi
    jle     loc_44BA7B
    mov     r14, buffer
    mov     r15, ptr
    mov     r12d, esi
    xor     ebx, ebx
    jmp     short loc_44BA0F
loc_44BA00:
    xor     eax, eax
loc_44BA02:
    mov     [buffer+i], al
    add     i, 1
    cmp     count, rbx
    jz      short loc_44BA7B
loc_44BA0F:
    movsd   xmm1, qword ptr [ptr+i*8]; x
    movapd  xmm0, xmm1
    andpd   xmm0, cs:xmmword_470F50
    ucomisd xmm0, cs:qword_470F18
    jz      short loc_44BA00
    movapd  xmm0, xmm1
    mulsd   xmm0, [rsp+48h+var_40]
    movapd  xmmword ptr [rsp+48h+var_38], xmm1
    call    psf_lrint_15
    movapd  xmm0, xmmword ptr [rsp+48h+var_38]
    ucomisd xmm0, ds:qword_470F20
    jnb     short loc_44BA70
    cdqe
    mov     ecx, offset ulaw_encode
    sub     rcx, rax
    movzx   eax, byte ptr [rcx]
    and     al, 7Fh
    jmp     short loc_44BA02
loc_44BA70:
    cdqe
    movzx   eax, ds:ulaw_encode[rax]
    jmp     short loc_44BA02
loc_44BA7B:
    add     rsp, 28h
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    retn
d2ulaw_array endp

