main proc
    push    rbp
    push    rbx
    lea     rbx, aD; "%d"
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rsp+28h+var_20], rax
    xor     eax, eax
    lea     rbp, [rsp+28h+var_24]
    call    sub_A40
    nop     word ptr [rax+rax+00000000h]
loc_8D0:
    xor     eax, eax
    call    sub_A70
    mov     rsi, rbp
    mov     rdi, rbx
    xor     eax, eax
    call    ___isoc99_scanf
    mov     rdi, cs:stdin; fp
    call    __IO_getc
    mov     eax, [rsp+28h+var_24]
    cmp     eax, 1
    jz      short loc_920
    cmp     eax, 2
    jz      short loc_910
    lea     rdi, s; "invalid choice"
    call    _puts
    jmp     short loc_8D0
loc_910:
    xor     eax, eax
    call    sub_B70
    jmp     short loc_8D0
loc_920:
    xor     eax, eax
    call    sub_AB0
    jmp     short loc_8D0
main endp

