sub_40144E proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    cmp     [rbp+var_18], 0
    jnz     short loc_401468
    mov     eax, 0
    jmp     short loc_4014B2
loc_401468:
    mov     rax, [rbp+var_18]
    mov     eax, [rax+0Ch]
    add     eax, 1
    mov     [rbp+var_4], eax
    mov     rax, [rbp+var_18]
    mov     eax, [rax+8]
    cmp     [rbp+var_4], eax
    jnz     short loc_401488
    mov     eax, 0
    jmp     short loc_4014B2
loc_401488:
    mov     rax, [rbp+var_18]
    mov     rax, [rax]
    mov     edx, [rbp+var_4]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rdx, rax
    mov     rax, [rbp+var_20]
    mov     [rdx], rax
    mov     rax, [rbp+var_18]
    mov     edx, [rbp+var_4]
    mov     [rax+0Ch], edx
    mov     eax, 1
loc_4014B2:
    pop     rbp
    retn
sub_40144E endp

