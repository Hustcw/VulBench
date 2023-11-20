handler proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset s; "Timeout"
    call    puts
    mov     edi, 1; status
    call    exit
handler endp

