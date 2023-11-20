sub_C10 proc
    push    rbx
    mov     esi, 8
    sub     rsp, 10h
    mov     rdi, rsp
    mov     [rsp+18h+var_18], 0
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    call    sub_B70
    xor     esi, esi; endptr
    mov     edx, 0Ah; base
    mov     rdi, rsp; nptr
    call    strtol
    mov     rcx, [rsp+18h+var_10]
    xor     rcx, fs:28h
    jnz     short loc_C5F
    add     rsp, 10h
    pop     rbx
    retn
loc_C5F:
    call    __stack_chk_fail
sub_C10 endp

