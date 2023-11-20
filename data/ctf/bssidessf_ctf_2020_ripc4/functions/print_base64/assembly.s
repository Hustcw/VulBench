print_base64 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+buf], rdi
    mov     [rbp+buflen], rsi
    mov     rcx, [rbp+buflen]
    mov     rax, [rbp+buf]
    mov     edx, 0; out_len
    mov     rsi, rcx; len
    mov     rdi, rax; src
    call    base64_encode
    mov     [rbp+encoded], rax
    cmp     [rbp+encoded], 0
    jz      short loc_1AE7
    mov     rax, [rbp+encoded]
    mov     rdi, rax; s
    call    _puts
    mov     rax, [rbp+encoded]
    mov     rdi, rax; ptr
    call    _free
    jmp     short locret_1AE8
loc_1AE7:
    nop
locret_1AE8:
    leave
    retn
print_base64 endp

