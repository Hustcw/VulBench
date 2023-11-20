sub_401476 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     edi, offset aSelectShield; "select shield"
    call    _puts
    mov     edi, offset a1Iceshield; "1. iceshield"
    call    _puts
    mov     edi, offset a2Fireshield; "2. fireshield"
    call    _puts
    mov     edi, offset a3Windshield; "3. windshield"
    call    _puts
    nop
    leave
    retn
sub_401476 endp

