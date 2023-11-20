recvlen_until proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+fd], edi
    mov     [rbp+haystack], rsi
    mov     [rbp+var_28], rdx
    mov     [rbp+needle], rcx
    mov     [rbp+var_10], 0
    jmp     short loc_13FE
loc_137F:
    mov     rax, [rbp+var_28]
    sub     rax, [rbp+var_10]
    mov     rdx, rax; n
    mov     rcx, [rbp+haystack]
    mov     rax, [rbp+var_10]
    lea     rsi, [rcx+rax]; buf
    mov     eax, [rbp+fd]
    mov     ecx, 0; flags
    mov     edi, eax; fd
    call    _recv
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0FFFFFFFFFFFFFFFFh
    jnz     short loc_13D3
    call    ___errno_location
    mov     eax, [rax]
    cmp     eax, 0Bh
    jz      short loc_13C8
    call    ___errno_location
    mov     eax, [rax]
    cmp     eax, 4
    jnz     short loc_13CA
loc_13C8:
    jmp     short loc_13FE
loc_13CA:
    mov     rax, 0FFFFFFFFFFFFFFFFh
    jmp     short locret_1410
loc_13D3:
    cmp     [rbp+var_8], 0
    jnz     short loc_13DC
    jmp     short loc_140C
loc_13DC:
    mov     rax, [rbp+var_8]
    add     [rbp+var_10], rax
    mov     rdx, [rbp+needle]
    mov     rax, [rbp+haystack]
    mov     rsi, rdx; needle
    mov     rdi, rax; haystack
    call    _strstr
    test    rax, rax
    jz      short loc_13FE
    jmp     short loc_140C
loc_13FE:
    mov     rax, [rbp+var_10]
    cmp     rax, [rbp+var_28]
    jb      loc_137F
loc_140C:
    mov     rax, [rbp+var_10]
locret_1410:
    leave
    retn
recvlen_until endp

