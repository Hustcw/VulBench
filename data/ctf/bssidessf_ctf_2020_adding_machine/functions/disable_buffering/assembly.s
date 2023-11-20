disable_buffering proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stderr@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1259
    call    ___stack_chk_fail
locret_1259:
    leave
    retn
disable_buffering endp

