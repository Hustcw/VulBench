d2alaw_array proc
    push    r15
    push    r14
    push    r12
    push    rbx
    sub     rsp, 18h
    movsd   [rsp+38h+var_30], xmm0
    test    esi, esi
    jle     short loc_430B2F
    mov     r14, buffer
    mov     r15, ptr
    mov     r12d, esi
    xor     ebx, ebx
    jmp     short loc_430AFC
loc_430AE0:
    cdqe
    mov     ecx, offset alaw_encode
    sub     rcx, rax
    movzx   eax, byte ptr [rcx]
    and     al, 7Fh
loc_430AEF:
    mov     [buffer+i], al
    add     i, 1
    cmp     count, rbx
    jz      short loc_430B2F
loc_430AFC:
    movsd   xmm0, qword ptr [ptr+i*8]
    movsd   [rsp+38h+var_28], xmm0
    mulsd   xmm0, [rsp+38h+var_30]
    call    psf_lrint_6
    movsd   xmm0, [rsp+38h+var_28]
    ucomisd xmm0, ds:qword_470D18
    jb      short loc_430AE0
    cdqe
    movzx   eax, ds:alaw_encode[rax]
    jmp     short loc_430AEF
loc_430B2F:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    retn
d2alaw_array endp

