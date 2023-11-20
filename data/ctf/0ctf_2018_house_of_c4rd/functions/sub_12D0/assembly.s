sub_12D0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    lea     rax, s; "———————————————————————————————————————"...
    mov     rdi, rax; s
    mov     [rbp+s], rax
    call    _puts
    lea     rdi, asc_1FD5; "\t"
    mov     [rbp+var_14], eax
    call    _puts
    mov     rdi, [rbp+s]; s
    mov     [rbp+var_18], eax
    call    _puts
    lea     rdi, a1; "1"
    mov     [rbp+var_1C], eax
    call    _puts
    lea     rdi, a2; "2"
    mov     [rbp+var_20], eax
    call    _puts
    lea     rdi, a3; "3"
    mov     [rbp+var_24], eax
    call    _puts
    lea     rdi, a4; "4"
    mov     [rbp+var_28], eax
    call    _puts
    mov     rdi, fs:28h
    mov     rcx, [rbp+var_8]
    cmp     rdi, rcx
    mov     [rbp+var_2C], eax
    jnz     loc_136E
    add     rsp, 30h
    pop     rbp
    retn
loc_136E:
    call    ___stack_chk_fail
sub_12D0 endp

