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
    mov     r13d, [rdi]
    test    i, i
    jz      short loc_5FCFAD
    mov     ebx, 8
    sub     rbx, i
    lea     rdi, [c+i]
    add     rdi, 4; dest
    cmp     j, len
    jbe     short loc_5FCF84
    mov     rsi, in; src
    mov     rdx, len; n
    call    _memcpy
    add     r12d, r13d
    jmp     short loc_5FCFDB
loc_5FCF84:
    mov     rsi, in; src
    mov     rdx, j; n
    call    _memcpy
    sub     len, j
    add     in, j
    mov     dword ptr [c], 0
    lea     rsi, [c+4]; in
    mov     edx, 8; len
    mov     rdi, c; c
    call    mdc2_body
loc_5FCFAD:
    mov     rbx, len
    and     rbx, 0FFFFFFFFFFFFFFF8h
    jz      short loc_5FCFC4
    mov     rdi, c; c
    mov     rsi, in; in
    mov     rdx, rbx; len
    call    mdc2_body
loc_5FCFC4:
    sub     j, rbx
    jz      short loc_5FCFDE
    lea     rdi, [c+4]; dest
    add     in, rbx
    mov     rsi, r15; src
    mov     rdx, r12; n
    call    _memcpy
loc_5FCFDB:
    mov     [c], r12d
loc_5FCFDE:
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

