sendlen proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+fd], edi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_28], rdx
    mov     [rbp+var_10], 0
    jmp     short loc_131D
loc_12C1:
    mov     rax, [rbp+var_28]
    sub     rax, [rbp+var_10]
    mov     rdx, rax; n
    mov     rcx, [rbp+var_20]
    mov     rax, [rbp+var_10]
    lea     rsi, [rcx+rax]; buf
    mov     eax, [rbp+fd]
    mov     ecx, 0; flags
    mov     edi, eax; fd
    call    _send
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0FFFFFFFFFFFFFFFFh
    jnz     short loc_1315
    call    ___errno_location
    mov     eax, [rax]
    cmp     eax, 0Bh
    jz      short loc_130A
    call    ___errno_location
    mov     eax, [rax]
    cmp     eax, 4
    jnz     short loc_130C
loc_130A:
    jmp     short loc_131D
loc_130C:
    mov     rax, 0FFFFFFFFFFFFFFFFh
    jmp     short locret_132B
loc_1315:
    mov     rax, [rbp+var_8]
    add     [rbp+var_10], rax
loc_131D:
    mov     rax, [rbp+var_10]
    cmp     rax, [rbp+var_28]
    jb      short loc_12C1
    mov     rax, [rbp+var_10]
locret_132B:
    leave
    retn
sendlen endp

