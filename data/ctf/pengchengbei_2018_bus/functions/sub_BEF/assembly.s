sub_BEF proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1BuyATicket; "1. buy a ticket"
    call    _puts
    lea     rdi, a2SelectDestina; "2. select destination"
    call    _puts
    lea     rdi, a3GetOnTheBusAn; "3. get on the bus and go"
    call    _puts
    lea     rdi, a4Exit; "4. exit"
    call    _puts
    lea     rdi, format; "What do you want to do:"
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
sub_BEF endp

