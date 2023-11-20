sub_A9B proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1AddNote; "1.Add note"
    call    puts
    lea     rdi, a2DeleteNote; "2.Delete note"
    call    puts
    lea     rdi, a3ShowNote; "3.Show note"
    call    puts
    lea     rdi, a4UpdateYourNam; "4.update your name"
    call    puts
    lea     rdi, a5EditNote; "5.Edit note"
    call    puts
    lea     rdi, a6Exit; "6.exit"
    call    puts
    nop
    pop     rbp
    retn
sub_A9B endp

