sub_B70 proc
    push    r12
    push    rbp
    push    rbx
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rsp+28h+var_20], rax
    xor     eax, eax
    test    rsi, rsi
    jz      short loc_BCD
    mov     rbx, rdi
    lea     rbp, [rdi+rsi]
    lea     r12, [rsp+28h+buf]
    jmp     short loc_BAB
loc_BA0:
    mov     [rbx], al
    add     rbx, 1
    cmp     rbx, rbp
    jz      short loc_BCD
loc_BAB:
    xor     edi, edi; fd
    mov     edx, 1; nbytes
    mov     rsi, r12; buf
    mov     [rsp+28h+buf], 0
    call    read
    test    rax, rax
    js      short loc_BE6
    movzx   eax, [rsp+28h+buf]
    cmp     al, 0Ah
    jnz     short loc_BA0
loc_BCD:
    mov     rax, [rsp+28h+var_20]
    xor     rax, fs:28h
    jnz     short loc_BFC
    add     rsp, 10h
    pop     rbx
    pop     rbp
    pop     r12
    retn
loc_BE6:
    lea     rdi, s; "Read error!!\n"
    call    puts
    mov     edi, 1; status
    call    exit
loc_BFC:
    call    __stack_chk_fail
sub_B70 endp

