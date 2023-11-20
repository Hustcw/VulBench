sub_1EF0 proc
    mov     rdx, rsi; stat_buf
    mov     rsi, rdi; filename
    mov     edi, 1; ver
    jmp     ___xstat
sub_1EF0 endp

