sub_A93 proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "1.Add a note"
    call    puts
    lea     rdi, a2ShowANote; "2.Show a note"
    call    puts
    lea     rdi, a3DeleteANote; "3.Delete a note"
    call    puts
    lea     rdi, a4ChangeNameOfA; "4.Change name of a note"
    call    puts
    lea     rdi, a5Exit; "5.Exit"
    call    puts
    nop
    pop     rbp
    retn
sub_A93 endp

