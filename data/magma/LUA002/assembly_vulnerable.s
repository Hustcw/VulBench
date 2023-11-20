changedline proc
    push    rbp
    push    r14
    push    rbx
    mov     ebx, edx
    mov     r14, p
    mov     eax, edx
    sub     eax, esi
    cmp     eax, 3Fh ; '?'
    jg      short loc_409548
    mov     rax, [p+58h]
    movsxd  rcx, esi
    movsxd  rdi, ebx
    xor     edx, edx
    xchg    ax, ax
loc_409530:
    movsx   ebp, byte ptr [rax+rcx+1]
    cmp     ebp, 0FFFFFF80h
    jz      short loc_409548
    inc     rcx
    add     edx, ebp
    cmp     rdi, rcx
    jnz     short loc_409530
    test    edx, edx
    jmp     short loc_40955E
loc_409548:
    mov     rdi, p; f
    call    luaG_getfuncline
    mov     ebp, eax
    mov     rdi, p; f
    mov     esi, ebx; pc
    call    luaG_getfuncline
    cmp     ebp, eax
loc_40955E:
    setnz   al
    movzx   eax, al
    pop     newpc
    pop     p
    pop     rbp
    retn
changedline endp

