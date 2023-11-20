sub_F09 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "index> "
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    sub_CD3
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 0
    js      short loc_F67
    cmp     [rbp+var_C], 13h
    jg      short loc_F67
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202100
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_F78
loc_F67:
    lea     rdi, aInvalidIndex; "invalid index"
    call    puts
    jmp     loc_1019
loc_F78:
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202060
    mov     rdx, [rdx+rax]; n
    mov     eax, [rbp+var_C]
    cdqe
    lea     rcx, ds:0[rax*8]
    lea     rax, qword_202100
    mov     rax, [rcx+rax]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202100
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202100
    mov     qword ptr [rdx+rax], 0
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202060
    mov     qword ptr [rdx+rax], 0
    lea     rdi, aDone; "done"
    call    puts
loc_1019:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_102D
    call    __stack_chk_fail
locret_102D:
    leave
    retn
sub_F09 endp

