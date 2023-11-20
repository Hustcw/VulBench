sub_1138 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "index: "
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_10]
    mov     edi, eax
    call    sub_BE0
    mov     [rbp+var_10], eax
    mov     eax, [rbp+var_10]
    mov     [rbp+var_C], eax
    cmp     [rbp+var_10], 0
    js      short loc_11E9
    cmp     [rbp+var_10], 0Fh
    jg      short loc_11E9
    mov     eax, [rbp+var_10]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202040
    mov     eax, [rdx+rax]
    mov     [rbp+var_10], eax
    cmp     [rbp+var_10], 1
    jnz     short loc_11E9
    lea     rdi, aContent; "content: "
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_C]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202044
    mov     edx, [rdx+rax]
    mov     eax, [rbp+var_C]
    cdqe
    shl     rax, 4
    mov     rcx, rax
    lea     rax, qword_202048
    mov     rax, [rcx+rax]
    mov     esi, edx
    mov     rdi, rax
    call    sub_10A4
    mov     [rbp+var_10], eax
loc_11E9:
    mov     eax, [rbp+var_10]
    mov     rsi, [rbp+var_8]
    xor     rsi, fs:28h
    jz      short locret_1200
    call    __stack_chk_fail
locret_1200:
    leave
    retn
sub_1138 endp

