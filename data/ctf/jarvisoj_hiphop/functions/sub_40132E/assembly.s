sub_40132E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     rax, [rbp+var_8]
    mov     rax, [rax]
    mov     rsi, rax
    mov     edi, offset format; "Your HP is %d\n"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+var_8]
    mov     rax, [rax]
    test    rax, rax
    jg      short loc_401378
    mov     edi, offset aGameOver; "game over"
    mov     eax, 0
    call    _printf
    mov     edi, 0FFFFFFFFh; status
    call    _exit
loc_401378:
    nop
    leave
    retn
sub_40132E endp

