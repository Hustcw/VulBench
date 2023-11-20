sub_11D5 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdin
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stderr
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stdout
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     edi, 3Ch ; '<'; seconds
    call    _alarm
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1247
    call    ___stack_chk_fail
locret_1247:
    leave
    retn
sub_11D5 endp

