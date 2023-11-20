findvararg proc
    mov     rax, [ci]
    mov     rcx, [rax]
    mov     rcx, [rcx+18h]
    cmp     byte ptr [rcx+0Bh], 0
    jz      short loc_4089EC
    movsxd  rcx, dword ptr [ci+2Ch]
    mov     edi, ecx
    neg     edi
    cmp     edi, esi
    jle     short loc_4089EF
loc_4089EC:
    xor     eax, eax
    retn
loc_4089EF:
    shl     nextra, 4
    sub     rax, rcx
    not     esi
    movsxd  rcx, esi
    shl     rcx, 4
    add     rcx, rax
    mov     [pos], rcx
    mov     eax, offset aVararg; "(vararg)"
    retn
findvararg endp



luaG_findlocal proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r14, pos
    mov     r15d, edx
    mov     rbx, ci
    mov     rbp, L
    mov     rax, [rsi]
    lea     r13, [rax+10h]
    test    byte ptr [rsi+3Eh], 2
    jnz     short loc_40894E
    test    r15d, r15d
    js      loc_4089AF
    mov     rax, [rax]
    mov     r12, [rax+18h]
    mov     rdi, ci; ci
    call    currentpc
    mov     rdi, r12; f
    mov     esi, r15d; local_number
    mov     edx, eax; pc
    call    luaF_getlocalname
    test    name, name
    jnz     short loc_40898A
loc_40894E:
    cmp     [L+20h], ci
    jz      short loc_40895A
    mov     L, [ci+18h]
    jmp     short loc_40895E
loc_40895A:
    add     L, 10h
loc_40895E:
    xor     eax, eax
    test    r15d, r15d
    jle     short loc_4089A0
    mov     rcx, [rbp+0]
    sub     rcx, base
    sar     rcx, 4
    movsxd  rdx, r15d
    cmp     rcx, rdx
    jl      short loc_4089A0
    test    byte ptr [ci+3Eh], 2
    mov     ecx, offset aTemporary; "(temporary)"
    mov     eax, offset aCTemporary; "(C temporary)"
    cmovz   rax, rcx
loc_40898A:
    test    pos, pos
    jz      short loc_4089A0
    movsxd  rcx, r15d
    shl     rcx, 4
    add     rcx, base
    add     rcx, 0FFFFFFFFFFFFFFF0h
    mov     [pos], rcx
loc_4089A0:
    add     rsp, 8
    pop     ci
    pop     r12
    pop     base
    pop     pos
    pop     n
    pop     rbp
    retn
loc_4089AF:
    mov     rdi, ci; ci
    mov     esi, r15d; n
    mov     rdx, pos; pos
    add     rsp, 8
    pop     ci
    pop     r12
    pop     base
    pop     pos
    pop     n
    pop     L
    jmp     short findvararg
luaG_findlocal endp

