sub_401B44 proc
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
    jz      short loc_401B9E
    lea     rdx, [rbp+var_8]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_4014B4
    test    eax, eax
    jz      short loc_401B9E
    mov     rdx, [rbp+var_10]
    mov     rax, [rbp+var_8]
    add     rdx, rax
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40144E
    jmp     short locret_401BA3
loc_401B9E:
    mov     eax, 0
locret_401BA3:
    leave
    retn
sub_401B44 endp

