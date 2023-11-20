sub_401CCE proc
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
    jz      short loc_401D30
    mov     rax, [rbp+var_18]
    mov     rdx, [rax]
    mov     rax, [rbp+var_18]
    mov     eax, [rax+0Ch]
    movsxd  rcx, eax
    mov     rax, [rbp+var_10]
    add     rax, rcx
    shl     rax, 3
    add     rax, rdx
    mov     rax, [rax]
    mov     [rbp+var_8], rax
    mov     rdx, [rbp+var_8]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40144E
    jmp     short locret_401D35
loc_401D30:
    mov     eax, 0
locret_401D35:
    leave
    retn
sub_401CCE endp

