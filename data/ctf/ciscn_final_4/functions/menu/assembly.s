menu proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset asc_40122B; "--------------------"
    call    puts
    mov     edi, offset aNote; "------- note -------"
    call    puts
    mov     edi, offset asc_40122B; "--------------------"
    call    puts
    mov     edi, offset a1New; "1. new"
    call    puts
    mov     edi, offset a2Delete; "2. delete"
    call    puts
    mov     edi, offset a3Write; "3. write"
    call    puts
    mov     edi, offset a4Exit; "4. exit"
    call    puts
    mov     edx, 3; n
    mov     esi, offset asc_401277; ">> "
    mov     edi, 1; fd
    call    write
    nop
    pop     rbp
    retn
menu endp

