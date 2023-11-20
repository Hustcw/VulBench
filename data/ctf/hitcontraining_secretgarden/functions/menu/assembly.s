menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; s
    call    _puts
    lea     rdi, byte_400FF0; s
    call    _puts
    lea     rdi, byte_401040; s
    call    _puts
    lea     rdi, byte_400FF0; s
    call    _puts
    lea     rdi, s; s
    call    _puts
    lea     rdi, a1RaiseAFlower; "  1 . Raise a flower "
    call    _puts
    lea     rdi, a2VisitTheGarde; "  2 . Visit the garden "
    call    _puts
    lea     rdi, a3RemoveAFlower; "  3 . Remove a flower from the garden"
    call    _puts
    lea     rdi, a4CleanTheGarde; "  4 . Clean the garden"
    call    _puts
    lea     rdi, a5LeaveTheGarde; "  5 . Leave the garden"
    call    _puts
    lea     rdi, s; s
    call    _puts
    lea     rdi, format; "Your choice : "
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
menu endp

