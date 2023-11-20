printmenu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, s; "1) Add note\n2) Edit note\n3) Remove no"...
    call    puts
    lea     rdi, asc_4011F5; ">> "
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    get_int
    pop     rbp
    retn
printmenu endp

