sub_FA4 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "index: "
    mov     eax, 0
    call    printf
    mov     rax, [rbp+var_10]
    mov     edi, eax
    call    sub_BE0
    cdqe
    mov     [rbp+var_10], rax
    mov     rax, [rbp+var_10]
    mov     [rbp+var_14], eax
    cmp     [rbp+var_10], 0
    js      loc_108A
    cmp     [rbp+var_10], 0Fh
    jg      loc_108A
    mov     rax, [rbp+var_10]
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202040
    mov     eax, [rdx+rax]
    cdqe
    mov     [rbp+var_10], rax
    cmp     [rbp+var_10], 1
    jnz     short loc_108A
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202040
    mov     dword ptr [rdx+rax], 0
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202044
    mov     dword ptr [rdx+rax], 0
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, qword_202048
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, qword_202048
    mov     qword ptr [rdx+rax], 0
loc_108A:
    mov     rax, [rbp+var_10]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_10A2
    call    __stack_chk_fail
locret_10A2:
    leave
    retn
sub_FA4 endp

