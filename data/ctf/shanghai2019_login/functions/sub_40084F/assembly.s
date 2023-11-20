sub_40084F proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "---Menu---"
    call    puts
    lea     rdi, a1Login; "1.login"
    call    puts
    lea     rdi, a2Register; "2.register"
    call    puts
    lea     rdi, a3Delete; "3.Delete"
    call    puts
    lea     rdi, a4Edit; "4.Edit"
    call    puts
    lea     rdi, a5Exit; "5.Exit"
    call    puts
    nop
    pop     rbp
    retn
sub_40084F endp

