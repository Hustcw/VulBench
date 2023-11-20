sub_D1B proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, aNoShowHaha; "No show haha!"
    call    puts
    nop
    pop     rbp
    retn
sub_D1B endp

