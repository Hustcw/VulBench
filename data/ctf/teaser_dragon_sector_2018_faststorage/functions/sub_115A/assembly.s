sub_115A proc
    push    rbp
    mov     rbp, rsp
    push    r12
    push    rbx
    sub     rsp, 10h
    mov     [rbp+n], 0
    mov     [rbp+s], 0
    lea     rdx, [rbp+n]
    lea     rax, [rbp+s]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_E3A
    test    eax, eax
    jnz     short loc_119A
    lea     rdi, aNoSuchEntry; "No such entry!"
    call    puts
    jmp     short loc_11E7
loc_119A:
    lea     rdi, aValue; "Value: "
    mov     eax, 0
    call    printf
    mov     rdx, [rbp+n]; n
    mov     rax, [rbp+s]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    mov     r12, [rbp+n]
    mov     rbx, [rbp+s]
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fileno
    mov     rdx, r12; nbytes
    mov     rsi, rbx; buf
    mov     edi, eax; fd
    call    read
loc_11E7:
    add     rsp, 10h
    pop     rbx
    pop     r12
    pop     rbp
    retn
sub_115A endp

