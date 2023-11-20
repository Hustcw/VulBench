sub_1521 proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, aYouDonTWantRed; "You don't want red packets!"
    call    _puts
    mov     edi, 0; status
    call    _exit
sub_1521 endp

