sub_1470 proc
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
    js      short loc_14CE
    cmp     [rbp+var_C], 13h
    jg      short loc_14CE
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_4060
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_14DC
loc_14CE:
    lea     rdi, s; "invalid"
    call    _puts
    jmp     short loc_1508
loc_14DC:
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_4060
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    _free
    lea     rdi, aDone; "Done!"
    call    _puts
loc_1508:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_151C
    call    ___stack_chk_fail
locret_151C:
    leave
    retn
sub_1470 endp

