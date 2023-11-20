sub_CC7 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
loc_CDE:
    lea     rdi, aNowBuyBuyBuy; "Now, buy buy buy!"
    call    _puts
    mov     rdx, cs:stdin; stream
    lea     rax, [rbp+s]
    mov     esi, 18h; n
    mov     rdi, rax; s
    call    _fgets
    lea     rax, [rbp+s]
    mov     edx, 0; base
    mov     esi, 0; endptr
    mov     rdi, rax; nptr
    call    _strtoul
    mov     [rbp+var_28], rax
    mov     rax, [rbp+var_28]
    cmp     rax, 2
    jz      short loc_D4E
    cmp     rax, 2
    ja      short loc_D34
    cmp     rax, 1
    jz      short loc_D42
    jmp     short loc_D65
loc_D34:
    cmp     rax, 3
    jz      short loc_D5A
    cmp     rax, 4
    jz      short loc_D6A
    jmp     short loc_D65
loc_D42:
    mov     eax, 0
    call    sub_9B0
    jmp     short loc_D65
loc_D4E:
    mov     eax, 0
    call    sub_B47
    jmp     short loc_D65
loc_D5A:
    mov     eax, 0
    call    sub_BD9
    nop
loc_D65:
    jmp     loc_CDE
loc_D6A:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_D7F
    call    ___stack_chk_fail
locret_D7F:
    leave
    retn
sub_CC7 endp

