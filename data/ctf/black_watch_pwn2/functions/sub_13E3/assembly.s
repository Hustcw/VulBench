sub_13E3 proc
    push    rbp
    mov     rbp, rsp
    add     rsp, 0FFFFFFFFFFFFFF80h
    mov     rax, cs:qword_4058
    add     rax, 800h
    mov     rax, [rax]
    mov     rdx, 7F0000000000h
    cmp     rax, rdx
    jle     short loc_1469
    mov     rax, cs:qword_4058
    add     rax, 7F8h
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_1469
    mov     rax, cs:qword_4058
    add     rax, 808h
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_1469
    lea     rdi, aYouGetRedPacke; "You get red packet!"
    call    _puts
    lea     rdi, format; "What do you want to say?"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 90h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    jmp     short loc_1473
loc_1469:
    mov     eax, 0
    call    sub_1521
loc_1473:
    nop
    leave
    retn
sub_13E3 endp

