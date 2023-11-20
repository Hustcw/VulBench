putsMenu proc
    push    rbp
    mov     rbp, rsp
    mov     esi, 1; newline
    lea     rdi, asc_1353; "----------------------"
    call    myputs
    mov     esi, 1; newline
    lea     rdi, a1AddNote; "1.add note"
    call    myputs
    mov     esi, 1; newline
    lea     rdi, a2DeleteNote; "2.delete note"
    call    myputs
    mov     esi, 1; newline
    lea     rdi, a3EncryptNote; "3.encrypt note"
    call    myputs
    mov     esi, 0; newline
    lea     rdi, asc_1392; ">>"
    call    myputs
    nop
    pop     rbp
    retn
putsMenu endp

