sub_401C06 proc
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
    jz      short loc_401C61
    lea     rdx, [rbp+var_8]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_4014B4
    test    eax, eax
    jz      short loc_401C61
    mov     rdx, [rbp+var_10]
    mov     rax, [rbp+var_8]
    imul    rdx, rax
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40144E
    jmp     short locret_401C66
loc_401C61:
    mov     eax, 0
locret_401C66:
    leave
    retn
sub_401C06 endp

