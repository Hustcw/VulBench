sub_C60 proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, aPleaseInputYou; "Please input your name"
    call    puts
    mov     edx, 31h ; '1'; nbytes
    lea     rax, unk_202060
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    nop
    pop     rbp
    retn
sub_C60 endp

