goodbye_message proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset aSeeYouNextTime; "See you next time"
    call    _puts
    mov     edi, offset aThanksYou; "Thanks you"
    call    _puts
    nop
    pop     rbp
    retn
goodbye_message endp

