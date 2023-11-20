recvlen proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+fd], edi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_28], rdx
    mov     [rbp+var_10], 0
    jmp     short loc_1294
loc_122F:
    mov     rax, [rbp+var_28]
    sub     rax, [rbp+var_10]
    mov     rdx, rax; n
    mov     rcx, [rbp+var_20]
    mov     rax, [rbp+var_10]
    lea     rsi, [rcx+rax]; buf
    mov     eax, [rbp+fd]
    mov     ecx, 0; flags
    mov     edi, eax; fd
    call    _recv
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0FFFFFFFFFFFFFFFFh
    jnz     short loc_1283
    call    ___errno_location
    mov     eax, [rax]
    cmp     eax, 0Bh
    jz      short loc_1278
    call    ___errno_location
    mov     eax, [rax]
    cmp     eax, 4
    jnz     short loc_127A
loc_1278:
    jmp     short loc_1294
loc_127A:
    mov     rax, 0FFFFFFFFFFFFFFFFh
    jmp     short locret_12A2
loc_1283:
    cmp     [rbp+var_8], 0
    jnz     short loc_128C
    jmp     short loc_129E
loc_128C:
    mov     rax, [rbp+var_8]
    add     [rbp+var_10], rax
loc_1294:
    mov     rax, [rbp+var_10]
    cmp     rax, [rbp+var_28]
    jb      short loc_122F
loc_129E:
    mov     rax, [rbp+var_10]
locret_12A2:
    leave
    retn
recvlen endp

