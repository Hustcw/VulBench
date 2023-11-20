sub_401D37 proc
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
    jz      short loc_401DA2
    lea     rdx, [rbp+var_8]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_4014B4
    test    eax, eax
    jz      short loc_401DA2
    mov     rax, [rbp+var_18]
    mov     rdx, [rax]
    mov     rax, [rbp+var_18]
    mov     eax, [rax+0Ch]
    movsxd  rcx, eax
    mov     rax, [rbp+var_10]
    add     rax, rcx
    shl     rax, 3
    add     rdx, rax
    mov     rax, [rbp+var_8]
    mov     [rdx], rax
    mov     eax, 1
    jmp     short locret_401DA7
loc_401DA2:
    mov     eax, 0
locret_401DA7:
    leave
    retn
sub_401D37 endp

