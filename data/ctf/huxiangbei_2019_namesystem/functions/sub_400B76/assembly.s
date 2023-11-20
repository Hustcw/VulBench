sub_400B76 proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset aWelcomeToThisE; "Welcome to this easy name system!"
    call    _puts
    mov     edi, offset a1AddName; "1.add name"
    call    _puts
    mov     edi, offset a2ShowName; "2.show name"
    call    _puts
    mov     edi, offset a3DropName; "3.drop name"
    call    _puts
    mov     edi, offset a4Exit; "4.exit"
    call    _puts
    mov     edi, offset aYourChoice; "Your choice :"
    call    _puts
    nop
    pop     rbp
    retn
sub_400B76 endp

