sub_4014B4 proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_8], rdi
    mov     [rbp+var_10], rsi
    cmp     [rbp+var_8], 0
    jnz     short loc_4014CE
    mov     eax, 0
    jmp     short loc_401518
loc_4014CE:
    mov     rax, [rbp+var_8]
    mov     eax, [rax+0Ch]
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_4014E1
    mov     eax, 0
    jmp     short loc_401518
loc_4014E1:
    mov     rax, [rbp+var_8]
    mov     rdx, [rax]
    mov     rax, [rbp+var_8]
    mov     eax, [rax+0Ch]
    cdqe
    shl     rax, 3
    add     rax, rdx
    mov     rdx, [rax]
    mov     rax, [rbp+var_10]
    mov     [rax], rdx
    mov     rax, [rbp+var_8]
    mov     eax, [rax+0Ch]
    lea     edx, [rax-1]
    mov     rax, [rbp+var_8]
    mov     [rax+0Ch], edx
    mov     eax, 1
loc_401518:
    pop     rbp
    retn
sub_4014B4 endp

