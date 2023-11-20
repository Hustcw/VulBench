stat proc
    mov     rdx, rsi; stat_buf
    mov     rsi, rdi; filename
    mov     edi, 1; ver
    jmp     ___xstat
stat endp

