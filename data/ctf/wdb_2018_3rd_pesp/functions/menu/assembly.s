menu proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset asc_400FC8; "----------------------------"
    call    _puts
    mov     edi, offset aPers0na1SpCe; "Pers0na1 Sp@ce"
    call    _puts
    mov     edi, offset asc_400FC8; "----------------------------"
    call    _puts
    mov     edi, offset a1ShowTheServan; "1.show the servant in the team"
    call    _puts
    mov     edi, offset a2AddANewServan; "2.add a new servant"
    call    _puts
    mov     edi, offset a3ChangeTheServ; "3.change the servant in the team"
    call    _puts
    mov     edi, offset a4RemoveTheServ; "4.remove the servant in the team"
    call    _puts
    mov     edi, offset a5Exit; "5.exit"
    call    _puts
    mov     edi, offset asc_400FC8; "----------------------------"
    call    _puts
    mov     edi, offset format; "Your choice:"
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
menu endp

