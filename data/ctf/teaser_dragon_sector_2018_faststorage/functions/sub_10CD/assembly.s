sub_10CD proc
    push    rbp
    mov     rbp, rsp
    push    r12
    push    rbx
    sub     rsp, 10h
    mov     [rbp+n], 0
    mov     [rbp+buf], 0
    lea     rdx, [rbp+n]
    lea     rax, [rbp+buf]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_E3A
    test    eax, eax
    jnz     short loc_110D
    lea     rdi, aNoSuchEntry; "No such entry!"
    call    puts
    jmp     short loc_1151
loc_110D:
    lea     rdi, aValue; "Value: "
    mov     eax, 0
    call    printf
    mov     r12, [rbp+n]
    mov     rbx, [rbp+buf]
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fileno
    mov     rdx, r12; n
    mov     rsi, rbx; buf
    mov     edi, eax; fd
    call    write
    lea     rdi, byte_1446; s
    call    puts
loc_1151:
    add     rsp, 10h
    pop     rbx
    pop     r12
    pop     rbp
    retn
sub_10CD endp

