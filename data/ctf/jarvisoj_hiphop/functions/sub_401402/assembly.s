sub_401402 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     edi, offset s; "select skill"
    call    _puts
    mov     edi, offset a1Attack; "1. attack"
    call    _puts
    mov     edi, offset a2Fireball; "2. fireball"
    call    _puts
    mov     edi, offset a3Iceball; "3. iceball"
    call    _puts
    mov     edi, offset a4Magicball; "4. magicball"
    call    _puts
    mov     edi, offset a5Lightning; "5. lightning"
    call    _puts
    mov     edi, offset a6Hellfire; "6. hellfire"
    call    _puts
    mov     edi, offset a7Icesword; "7. icesword"
    call    _puts
    mov     edi, offset a8Magicsword; "8. magicsword"
    call    _puts
    mov     edi, offset a9Hollylight; "9. hollylight"
    call    _puts
    nop
    leave
    retn
sub_401402 endp

