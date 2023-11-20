print_menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "================================="
    call    _puts
    lea     rdi, a1Malloc; "1. malloc"
    call    _puts
    lea     rdi, a2Calloc; "2. calloc"
    call    _puts
    lea     rdi, a3Realloc; "3. realloc"
    call    _puts
    lea     rdi, a4Free; "4. free"
    call    _puts
    lea     rdi, a5Exit; "5. exit"
    call    _puts
    lea     rdi, s; "================================="
    call    _puts
    nop
    pop     rbp
    retn
print_menu endp

