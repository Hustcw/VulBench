sub_AD6 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+buf], rdi
    mov     [rbp+var_10], rsi
    mov     rax, [rbp+var_10]
    movzx   edx, ax; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     rdx, rax
    mov     rax, [rbp+buf]
    add     rax, rdx
    mov     byte ptr [rax], 0
    nop
    leave
    retn
sub_AD6 endp

