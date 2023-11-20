request_header proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+s2], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, reqhdr
    mov     [rbp+var_10], rax
    jmp     short loc_13CA
loc_13A1:
    mov     rax, [rbp+var_10]
    mov     rax, [rax]
    mov     rdx, [rbp+s2]
    mov     rsi, rdx; s2
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_13C5
    mov     rax, [rbp+var_10]
    mov     rax, [rax+8]
    jmp     short loc_13DB
loc_13C5:
    add     [rbp+var_10], 10h
loc_13CA:
    mov     rax, [rbp+var_10]
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_13A1
    mov     eax, 0
loc_13DB:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_13EF
    call    ___stack_chk_fail
locret_13EF:
    leave
    retn
request_header endp

