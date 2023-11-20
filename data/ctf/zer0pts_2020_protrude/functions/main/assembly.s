main proc
    push    rbp
    mov     rbp, rsp
    mov     eax, 0
    call    setup
    lea     rdi, aN; "n = "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    read_long
    mov     cs:n, rax
    mov     rax, cs:n
    test    rax, rax
    jle     short loc_400A02
    mov     rax, cs:n
    cmp     rax, 16h
    jle     short loc_400A10
loc_400A02:
    lea     rdi, aInvalidInput; "Invalid input"
    call    _puts
    jmp     short loc_400A15
loc_400A10:
    call    calc_sum
loc_400A15:
    mov     eax, 0
    pop     rbp
    retn
main endp

