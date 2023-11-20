sub_401AF8 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    lea     rdx, [rbp+var_8]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_4014B4
    test    eax, eax
    jz      short loc_401B3D
    mov     rdx, [rbp+var_8]
    mov     rax, [rbp+var_20]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40144E
    test    eax, eax
    jz      short loc_401B3D
    mov     eax, 1
    jmp     short locret_401B42
loc_401B3D:
    mov     eax, 0
locret_401B42:
    leave
    retn
sub_401AF8 endp

