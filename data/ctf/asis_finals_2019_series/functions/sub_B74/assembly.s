sub_B74 proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, aA; "A = "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_B1A
    mov     cs:qword_202050, rax
    lea     rdi, aB; "B = "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_B1A
    mov     cs:qword_202058, rax
    nop
    pop     rbp
    retn
sub_B74 endp

