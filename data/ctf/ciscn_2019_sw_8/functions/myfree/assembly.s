myfree proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+ptr], rdi
    mov     rax, [rbp+ptr]
    mov     rax, [rax-8]
    mov     [rbp+size], rax
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    cmp     [rbp+size], 90h
    jbe     short loc_F63
    mov     rax, [rbp+size]
    and     rax, 0FFFFFFFFFFFFFFF8h
    lea     rdx, [rax-8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     rax, [rax]
    mov     [rbp+next_size], rax
    mov     rax, [rbp+next_size]
    and     eax, 1
    test    rax, rax
    jz      short loc_F63
    lea     rdi, aDown; "Down"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_F63:
    lea     rdi, aSuccess; "success"
    call    _puts
    nop
    leave
    retn
myfree endp

