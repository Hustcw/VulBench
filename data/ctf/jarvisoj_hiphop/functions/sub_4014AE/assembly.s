sub_4014AE proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     edi, offset aYouHaveToKillT; "You have to kill the boss monster. You "...
    call    _puts
    nop
    leave
    retn
sub_4014AE endp

