sub_BD2 proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1AddNote; "1.add note"
    call    _puts
    lea     rdi, a2DeleteNote; "2.delete note"
    call    _puts
    lea     rdi, a3ShowNote; "3.show note"
    call    _puts
    lea     rdi, format; ">> "
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
sub_BD2 endp

