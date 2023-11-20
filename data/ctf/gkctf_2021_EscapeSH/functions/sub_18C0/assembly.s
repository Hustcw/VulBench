sub_18C0 proc
    push    rbx
    mov     esi, 300h; size
    sub     rsp, 310h
    mov     rdi, rsp; buf
    mov     rax, fs:28h
    mov     [rsp+318h+var_10], rax
    xor     eax, eax
    call    getcwd
    test    rax, rax
    jz      short loc_1918
    mov     rdi, rsp; s
    call    puts
loc_18F5:
    mov     rax, [rsp+318h+var_10]
    xor     rax, fs:28h
    jnz     short loc_1926
    add     rsp, 310h
    pop     rbx
    retn
loc_1918:
    lea     rdi, aError; "error!"
    call    puts
    jmp     short loc_18F5
loc_1926:
    call    __stack_chk_fail
sub_18C0 endp

