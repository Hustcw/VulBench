sub_A70 proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "ouch"
    call    puts
    mov     edi, 0; status
    call    exit
sub_A70 endp

