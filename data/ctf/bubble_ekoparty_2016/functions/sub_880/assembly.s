sub_880 proc
    push    rbp
    mov     rbp, rsp
    lea     rsi, format; "[-] Bad number."
    mov     edi, 0FFFFFFFFh; status
    mov     eax, 0
    call    err
sub_880 endp

