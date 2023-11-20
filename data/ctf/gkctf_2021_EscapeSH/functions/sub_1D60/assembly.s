sub_1D60 proc
    sub     rsp, 8
    lea     rax, qword_204040
    xor     esi, esi; type
    mov     rdi, [rax+8]; name
    call    access
    test    eax, eax
    jnz     short loc_1D88
    add     rsp, 8
    jmp     sub_1260
loc_1D88:
    lea     rdi, aNoSuchFileOrDi; "No such file or directory!"
    add     rsp, 8
    jmp     puts
sub_1D60 endp

