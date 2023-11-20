sub_13E0 proc
    push    rbx
    mov     esi, 8
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    mov     rbx, rsp
    mov     [rsp+18h+var_18], 0
    mov     rdi, rbx
    call    sub_1350
    xor     esi, esi; endptr
    mov     edx, 0Ah; base
    mov     rdi, rbx; nptr
    call    _strtol
    mov     rcx, [rsp+18h+var_10]
    xor     rcx, fs:28h
    jnz     short loc_1432
    add     rsp, 10h
    pop     rbx
    retn
loc_1432:
    call    ___stack_chk_fail
sub_13E0 endp

