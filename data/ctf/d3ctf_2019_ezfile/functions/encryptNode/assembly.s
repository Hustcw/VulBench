encryptNode proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 60h
    mov     esi, 0; newline
    lea     rdi, aInputTheIndexT; "input the index to encrypt >>"
    call    myputs
    mov     eax, 0
    call    getNumber
    mov     [rbp+index], eax
    mov     esi, 0; newline
    lea     rdi, aInputTheSizeOf; "input the size of the seed (max 0x50) >"...
    call    myputs
    mov     eax, 0
    call    getNumber
    mov     [rbp+size], eax
    cmp     [rbp+size], 0
    js      short loc_10A8
    cmp     [rbp+size], 70h ; 'p'
    jle     short loc_10AF
loc_10A8:
    mov     [rbp+size], 70h ; 'p'
loc_10AF:
    mov     esi, 0; newline
    lea     rdi, aInputTheCryptS; "input the crypt seed >>"
    call    myputs
    mov     edx, [rbp+size]
    lea     rax, [rbp+seed]
    mov     esi, edx; size
    mov     rdi, rax; buf
    call    getContent
    mov     edx, [rbp+index]
    lea     rax, [rbp+seed]
    mov     esi, edx; index
    mov     rdi, rax; seed
    call    doSomeThing
    nop
    leave
    retn
encryptNode endp

