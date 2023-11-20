hello_message proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset s; "There is a team with servant"
    call    _puts
    mov     edi, offset aWhatDoYouWantT; "what do you want to do in the team"
    call    _puts
    nop
    pop     rbp
    retn
hello_message endp

