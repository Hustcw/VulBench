check proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     [rbp+var_18], esi
    mov     [rbp+var_1C], edx
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, [rbp+var_14]
    cmp     eax, [rbp+var_18]
    jz      short loc_DEC
    cmp     [rbp+var_1C], 0
    js      short loc_DEC
    cmp     [rbp+var_14], 1Dh
    jg      short loc_DEC
    cmp     [rbp+var_14], 0
    js      short loc_DEC
    cmp     [rbp+var_18], 1Dh
    jg      short loc_DEC
    cmp     [rbp+var_18], 0
    js      short loc_DEC
    mov     eax, [rbp+var_18]
    movsxd  rcx, eax
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 4
    sub     rax, rdx
    add     rax, rax
    add     rax, rcx
    lea     rdx, ds:0[rax*4]
    lea     rax, used
    mov     eax, [rdx+rax]
    test    eax, eax
    jz      short loc_DF3
loc_DEC:
    mov     eax, 0
    jmp     short loc_E2A
loc_DF3:
    mov     eax, [rbp+var_18]
    movsxd  rcx, eax
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 4
    sub     rax, rdx
    add     rax, rax
    add     rax, rcx
    lea     rdx, ds:0[rax*4]
    lea     rax, used
    mov     dword ptr [rdx+rax], 1
    mov     eax, 1
loc_E2A:
    mov     rsi, [rbp+var_8]
    xor     rsi, fs:28h
    jz      short locret_E3E
    call    ___stack_chk_fail
locret_E3E:
    leave
    retn
check endp

