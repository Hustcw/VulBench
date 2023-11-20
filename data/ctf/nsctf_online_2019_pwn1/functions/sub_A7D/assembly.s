sub_A7D proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1AddNote; "1.Add note"
    call    puts
    lea     rdi, a2DeleteNote; "2.Delete note"
    call    puts
    lea     rdi, a3ShowNote; "3.Show note"
    call    puts
    lea     rdi, a4UpdateNote; "4.Update note"
    call    puts
    lea     rdi, a5Exit; "5.exit"
    call    puts
    nop
    pop     rbp
    retn
sub_A7D endp

