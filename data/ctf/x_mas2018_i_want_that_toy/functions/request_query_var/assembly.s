request_query_var proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+s2], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, reqvars
    mov     [rbp+var_10], rax
    mov     [rbp+var_14], 0
    jmp     short loc_147A
loc_1420:
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 5
    mov     rdx, rax
    mov     rax, [rbp+var_10]
    add     rax, rdx
    mov     rdx, rax
    mov     rax, [rbp+s2]
    mov     rsi, rax; s2
    mov     rdi, rdx; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_1476
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 5
    mov     rdx, rax
    mov     rax, [rbp+var_10]
    add     rax, rdx
    add     rax, 20h ; ' '
    jmp     short loc_148A
loc_1476:
    add     [rbp+var_14], 1
loc_147A:
    mov     eax, cs:req_cvar
    cmp     [rbp+var_14], eax
    jl      short loc_1420
    mov     eax, 0
loc_148A:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_149E
    call    ___stack_chk_fail
locret_149E:
    leave
    retn
request_query_var endp

