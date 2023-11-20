sub_401AAC proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    lea     rdx, [rbp+var_8]
    mov     rax, [rbp+var_20]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_4014B4
    test    eax, eax
    jz      short loc_401AF1
    mov     rdx, [rbp+var_8]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40144E
    test    eax, eax
    jz      short loc_401AF1
    mov     eax, 1
    jmp     short locret_401AF6
loc_401AF1:
    mov     eax, 0
locret_401AF6:
    leave
    retn
sub_401AAC endp

