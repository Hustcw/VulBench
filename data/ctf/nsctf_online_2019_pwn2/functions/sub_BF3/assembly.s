sub_BF3 proc
    push    rbp
    mov     rbp, rsp
    lea     rax, qword_202090
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_C18
    lea     rax, qword_202090
    mov     rax, [rax]
    mov     rdi, rax; s
    call    puts
loc_C18:
    nop
    pop     rbp
    retn
sub_BF3 endp

