sub_114B proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1CreateString; "1.create string"
    call    _puts
    lea     rdi, a2DeleteString; "2.delete string"
    call    _puts
    lea     rdi, a3Quit; "3.quit"
    call    _puts
    pop     rbp
    retn
sub_114B endp

