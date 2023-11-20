sub_4008F4 proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset s; "1.new"
    call    puts
    mov     edi, offset a2Change; "2.change"
    call    puts
    mov     edi, offset a3Release; "3.release"
    call    puts
    mov     edi, offset a4Exit; "4.exit"
    call    puts
    mov     edi, offset format; "Choice:"
    mov     eax, 0
    call    printf
    nop
    pop     rbp
    retn
sub_4008F4 endp

