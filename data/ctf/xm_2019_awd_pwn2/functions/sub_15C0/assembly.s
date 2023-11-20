sub_15C0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, a1Alloc; "1.alloc"
    call    _puts
    lea     rdi, a2Delete; "2.delete"
    call    _puts
    lea     rdi, a3Show; "3.show"
    call    _puts
    lea     rdi, a4Exit; "4.exit"
    call    _puts
    lea     rdi, asc_204A; ">>"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_12EC
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_C]
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_163C
    call    ___stack_chk_fail
locret_163C:
    leave
    retn
sub_15C0 endp

