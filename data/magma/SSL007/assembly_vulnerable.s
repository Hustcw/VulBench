MDC2_Update proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r12, len
    mov     r15, in
    mov     r14, c
    mov     ebx, [rdi]
    test    i, i
    jz      short loc_4B66ED
    lea     rax, [i+len]
    cmp     rax, 7
    ja      short loc_4B66B0
    lea     rdi, [c+i]
    add     rdi, 4; dest
    mov     rsi, in; src
    mov     rdx, len; n
    call    _memcpy
    add     r12d, ebx
    jmp     short loc_4B671B
loc_4B66B0:
    mov     r13d, 8
    sub     r13, i
    lea     rdi, [c+i]
    add     rdi, 4; dest
    lea     i, [c+4]
    mov     rsi, j; src
    mov     rdx, r13; n
    call    _memcpy
    sub     len, r13
    add     j, r13
    mov     dword ptr [c], 0
    mov     edx, 8; len
    mov     rdi, c; c
    mov     rsi, rbx; in
    call    mdc2_body
loc_4B66ED:
    mov     rbx, len
    and     rbx, 0FFFFFFFFFFFFFFF8h
    jz      short loc_4B6704
    mov     rdi, c; c
    mov     rsi, in; in
    mov     rdx, rbx; len
    call    mdc2_body
loc_4B6704:
    sub     j, rbx
    jz      short loc_4B671E
    lea     rdi, [c+4]; dest
    add     in, rbx
    mov     rsi, r15; src
    mov     rdx, r12; n
    call    _memcpy
loc_4B671B:
    mov     [c], r12d
loc_4B671E:
    mov     eax, 1
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     r13
    pop     c
    pop     r15
    pop     rbp
    retn
MDC2_Update endp

