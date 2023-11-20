alarmHandler proc
    push    rbp
    mov     rbp, rsp
    mov     esi, 1; newline
    lea     rdi, str; "time out"
    call    myputs
    mov     edi, 0; status
    call    _exit
alarmHandler endp

