menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "welcome!"
    call    _puts
    lea     rdi, a1Add; "1. add"
    call    _puts
    lea     rdi, a2Edit; "2. edit"
    call    _puts
    lea     rdi, a3Show; "3. show"
    call    _puts
    lea     rdi, a4Delete; "4. delete"
    call    _puts
    lea     rdi, a5Exit; "5. exit"
    call    _puts
    lea     rdi, aPleaseInputCho; "please input choice: "
    call    _puts
    nop
    pop     rbp
    retn
menu endp

