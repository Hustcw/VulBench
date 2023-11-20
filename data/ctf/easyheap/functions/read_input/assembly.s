read_input proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+buf], rdi
    mov     [rbp+nbytes], rsi
    mov     rdx, [rbp+nbytes]; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    jg      short loc_4008C8
    mov     edi, offset s; "Error"
    call    _puts
    mov     edi, 0FFFFFFFFh; status
    call    __exit
loc_4008C8:
    nop
    leave
    retn
read_input endp

