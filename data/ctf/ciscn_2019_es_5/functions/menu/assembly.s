menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1CreateFlag; "1.Create flag"
    call    _puts
    lea     rdi, a2EditFlag; "2.Edit flag"
    call    _puts
    lea     rdi, a3ShowFlag; "3.Show flag"
    call    _puts
    lea     rdi, a4DeleteFlag; "4.Delete flag"
    call    _puts
    lea     rdi, a5Exit; "5.Exit"
    call    _puts
    lea     rdi, format; "Your choice:"
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
menu endp

