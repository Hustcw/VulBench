add_nums proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_28], rdi
    mov     eax, esi
    mov     [rbp+var_2C], al
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_10], 0
    mov     [rbp+var_14], 0
    jmp     short loc_160C
loc_15ED:
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     rax, [rax]
    add     [rbp+var_10], rax
    add     [rbp+var_14], 1
loc_160C:
    movzx   eax, [rbp+var_2C]
    cmp     [rbp+var_14], eax
    jl      short loc_15ED
    mov     rax, [rbp+var_10]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_162D
    call    ___stack_chk_fail
locret_162D:
    leave
    retn
add_nums endp

