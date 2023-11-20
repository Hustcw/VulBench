sub_401C68 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    lea     rdx, [rbp+var_10]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_4014B4
    test    eax, eax
    jz      short loc_401CC7
    lea     rdx, [rbp+var_8]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_4014B4
    test    eax, eax
    jz      short loc_401CC7
    mov     rax, [rbp+var_10]
    mov     rcx, [rbp+var_8]
    cqo
    idiv    rcx
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40144E
    jmp     short locret_401CCC
loc_401CC7:
    mov     eax, 0
locret_401CCC:
    leave
    retn
sub_401C68 endp

