sub_124B proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a0Exit; "0. Exit"
    call    puts
    lea     rdi, a1AddEntry; "1. Add entry"
    call    puts
    lea     rdi, a2PrintEntry; "2. Print entry"
    call    puts
    lea     rdi, a3EditEntry; "3. Edit entry"
    call    puts
    lea     rdi, asc_1688; "> "
    mov     eax, 0
    call    printf
    nop
    pop     rbp
    retn
sub_124B endp

