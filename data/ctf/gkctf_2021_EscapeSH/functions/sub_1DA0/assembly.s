sub_1DA0 proc
    lea     rsi, a2j; "\x1B[2J"
    sub     rsp, 8
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
    lea     rsi, asc_2BD8; "\x1B[H"
    mov     edi, 1
    xor     eax, eax
    add     rsp, 8
    jmp     __printf_chk
sub_1DA0 endp

