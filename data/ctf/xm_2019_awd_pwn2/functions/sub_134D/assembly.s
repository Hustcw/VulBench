sub_134D proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, format; "size:"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_12EC
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 0
    jle     short loc_1391
    cmp     [rbp+var_C], 0FFFh
    jle     short loc_13A2
loc_1391:
    lea     rdi, s; "invalid"
    call    _puts
    jmp     loc_145A
loc_13A2:
    mov     [rbp+var_10], 0
    mov     [rbp+var_10], 0
    jmp     short loc_13D3
loc_13B2:
    mov     eax, [rbp+var_10]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_4060
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_13DB
    add     [rbp+var_10], 1
loc_13D3:
    cmp     [rbp+var_10], 13h
    jle     short loc_13B2
    jmp     short loc_13DC
loc_13DB:
    nop
loc_13DC:
    cmp     [rbp+var_10], 13h
    jle     short loc_13F0
    lea     rdi, aFull; "full"
    call    _puts
    jmp     short loc_145A
loc_13F0:
    mov     eax, [rbp+var_C]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rcx, rax
    mov     eax, [rbp+var_10]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_4060
    mov     [rdx+rax], rcx
    lea     rdi, aContent; "content:"
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_10]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_4060
    mov     rax, [rdx+rax]
    mov     edx, [rbp+var_C]
    mov     esi, edx
    mov     rdi, rax
    call    sub_1249
    lea     rdi, aDone; "Done!"
    call    _puts
loc_145A:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_146E
    call    ___stack_chk_fail
locret_146E:
    leave
    retn
sub_134D endp

