sub_102F proc
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
    js      short loc_108D
    cmp     [rbp+var_C], 13h
    jg      short loc_108D
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202100
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_109B
loc_108D:
    lea     rdi, aInvalidIndex; "invalid index"
    call    puts
    jmp     short loc_10BB
loc_109B:
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202100
    mov     rax, [rdx+rax]
    mov     rdi, rax; s
    call    puts
loc_10BB:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_10CF
    call    __stack_chk_fail
locret_10CF:
    leave
    retn
sub_102F endp

