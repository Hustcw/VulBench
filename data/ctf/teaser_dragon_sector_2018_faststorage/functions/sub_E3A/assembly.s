sub_E3A proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 120h
    mov     [rbp+var_118], rdi
    mov     [rbp+var_120], rsi
    lea     rdx, [rbp+buf]
    mov     eax, 0
    mov     ecx, 20h ; ' '
    mov     rdi, rdx
    rep stosq
    mov     [rbp+var_8], 0
    mov     [rbp+var_10], 0
    lea     rdi, format; "Name: "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fileno
    mov     ecx, eax
    lea     rax, [rbp+buf]
    mov     edx, 100h; nbytes
    mov     rsi, rax; buf
    mov     edi, ecx; fd
    call    read
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0
    jg      short loc_ECA
    mov     eax, 0
    call    sub_A70
loc_ECA:
    mov     [rbp+var_11], 0
    lea     rax, [rbp+buf]
    mov     rdi, rax
    call    sub_D54
    mov     [rbp+var_10], rax
    cmp     [rbp+var_10], 0
    jnz     short loc_EEF
    mov     eax, 0
    jmp     short locret_F27
loc_EEF:
    mov     rax, [rbp+var_10]
    shr     rax, 30h
    mov     rdx, rax
    mov     rax, [rbp+var_120]
    mov     [rax], rdx
    mov     rdx, [rbp+var_10]
    mov     rax, 0FFFFFFFFFFFFh
    and     rax, rdx
    mov     rdx, rax
    mov     rax, [rbp+var_118]
    mov     [rax], rdx
    mov     eax, 1
locret_F27:
    leave
    retn
sub_E3A endp

