sub_E98 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "index: "
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_14]
    mov     edi, eax
    call    sub_BE0
    mov     [rbp+var_14], eax
    mov     eax, [rbp+var_14]
    mov     [rbp+var_10], eax
    cmp     [rbp+var_14], 0
    js      loc_F8B
    cmp     [rbp+var_14], 0Fh
    jg      loc_F8B
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202040
    mov     eax, [rdx+rax]
    mov     [rbp+var_14], eax
    cmp     [rbp+var_14], 1
    jnz     loc_F8B
    lea     rdi, aSize; "size: "
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_14]
    mov     edi, eax
    call    sub_BE0
    mov     [rbp+var_14], eax
    mov     eax, [rbp+var_10]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202044
    mov     eax, [rdx+rax]
    mov     edx, [rbp+var_14]
    mov     esi, edx
    mov     edi, eax
    call    sub_E3C
    mov     [rbp+var_C], eax
    cmp     [rbp+var_14], 0
    jle     short loc_F8B
    lea     rdi, aContent; "content: "
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_10]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, qword_202048
    mov     rax, [rdx+rax]
    mov     edx, [rbp+var_C]
    mov     esi, edx
    mov     rdi, rax
    call    sub_DA8
    mov     [rbp+var_14], eax
loc_F8B:
    mov     eax, [rbp+var_14]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_FA2
    call    __stack_chk_fail
locret_FA2:
    leave
    retn
sub_E98 endp

