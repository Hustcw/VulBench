sub_A70 proc
    lea     rdi, a1NewNote; "1.new_note"
    sub     rsp, 8
    call    _puts
    lea     rdi, a2FreeNote; "2.free_note"
    call    _puts
    lea     rsi, asc_CBB; ">> "
    mov     edi, 1
    xor     eax, eax
    add     rsp, 8
    jmp     ___printf_chk
sub_A70 endp

