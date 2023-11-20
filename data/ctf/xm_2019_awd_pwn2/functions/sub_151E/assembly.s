sub_151E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIdx; "idx:"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_12EC
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 0
    js      short loc_157C
    cmp     [rbp+var_C], 13h
    jg      short loc_157C
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_4060
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_158A
loc_157C:
    lea     rdi, s; "invalid"
    call    _puts
    jmp     short loc_15AA
loc_158A:
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_4060
    mov     rax, [rdx+rax]
    mov     rdi, rax; s
    call    _puts
loc_15AA:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_15BE
    call    ___stack_chk_fail
locret_15BE:
    leave
    retn
sub_151E endp

