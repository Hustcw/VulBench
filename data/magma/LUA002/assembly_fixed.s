changedline proc
    push    rbp
    push    r15
    push    r14
    push    rbx
    push    rax
    mov     rax, [p+58h]
    test    rax, rax
    jz      short loc_409556
    mov     r15d, edx
    mov     rbx, p
    mov     ecx, edx
    sub     ecx, esi
    cmp     ecx, 3Fh ; '?'
    jg      short loc_409538
    movsxd  rcx, esi
    movsxd  rdi, r15d
    xor     edx, edx
    nop     word ptr [rax+rax+00000000h]
loc_409520:
    movsx   ebp, byte ptr [rax+rcx+1]
    cmp     ebp, 0FFFFFF80h
    jz      short loc_409538
    inc     rcx
    add     edx, ebp
    cmp     rdi, rcx
    jnz     short loc_409520
    test    edx, edx
    jmp     short loc_409551
loc_409538:
    mov     rdi, p; f
    call    luaG_getfuncline
    mov     r14d, eax
    mov     rdi, p; f
    mov     esi, r15d; pc
    call    luaG_getfuncline
    cmp     r14d, eax
loc_409551:
    setnz   al
    jmp     short loc_409558
loc_409556:
    xor     eax, eax
loc_409558:
    movzx   eax, al
    add     rsp, 8
    pop     rbx
    pop     r14
    pop     r15
    pop     rbp
    retn
changedline endp

