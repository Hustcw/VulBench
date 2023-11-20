handler proc
    sub     rsp, 8
    lea     rdi, s; "Time is up"
    call    puts
    mov     edi, 1; status
    call    exit
handler endp

