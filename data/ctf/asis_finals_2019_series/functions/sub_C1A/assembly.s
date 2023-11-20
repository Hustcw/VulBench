sub_C1A proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 8
    lea     rdi, aX0; "x0 = "
    mov     eax, 0
    call    _printf
    mov     rbx, cs:qword_202068
    mov     eax, 0
    call    sub_B1A
    mov     [rbx], rax
    lea     rdi, aX1; "x1 = "
    mov     eax, 0
    call    _printf
    mov     rax, cs:qword_202068
    lea     rbx, [rax+8]
    mov     eax, 0
    call    sub_B1A
    mov     [rbx], rax
    nop
    add     rsp, 8
    pop     rbx
    pop     rbp
    retn
sub_C1A endp

