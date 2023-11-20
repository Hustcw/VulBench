begin proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset asc_400CE0; "======================================="...
    call    _puts
    mov     edi, offset a1Encrypt; "1.Encrypt"
    call    _puts
    mov     edi, offset a2Decrypt; "2.Decrypt"
    call    _puts
    mov     edi, offset a3Exit; "3.Exit"
    call    _puts
    mov     edi, offset aInputYourChoic; "Input your choice!"
    call    _puts
    nop
    pop     rbp
    retn
begin endp

