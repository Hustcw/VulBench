sub_B9A proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_14], edi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_28], rdx
    mov     edi, 18h; size
    call    malloc
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0
    jnz     short loc_BCC
    mov     eax, 0
    call    sub_A70
loc_BCC:
    mov     rax, [rbp+var_8]
    mov     rdx, [rbp+var_20]
    mov     [rax+8], rdx
    mov     rax, [rbp+var_8]
    mov     rdx, [rbp+var_28]
    mov     [rax+10h], rdx
    lea     rax, qword_202140
    mov     edx, [rbp+var_14]
    movsxd  rdx, edx
    mov     rdx, [rax+rdx*8]
    mov     rax, [rbp+var_8]
    mov     [rax], rdx
    lea     rax, qword_202140
    mov     edx, [rbp+var_14]
    movsxd  rdx, edx
    mov     rcx, [rbp+var_8]
    mov     [rax+rdx*8], rcx
    nop
    leave
    retn
sub_B9A endp

