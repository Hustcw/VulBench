sub_BBF proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, aN; "n = "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_B1A
    mov     cs:dword_202060, eax
    mov     eax, cs:dword_202060
    cdqe
    shl     rax, 3
    mov     rdi, rax; size
    call    _malloc
    mov     cs:qword_202068, rax
    mov     rax, cs:qword_202068
    test    rax, rax
    jnz     short loc_C17
    lea     rdi, aCouldNotAlloca; "Could not allocate memory"
    call    sub_A97
loc_C17:
    nop
    pop     rbp
    retn
sub_BBF endp

