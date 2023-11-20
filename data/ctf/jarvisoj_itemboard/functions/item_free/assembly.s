item_free proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+item], rdi
    mov     rax, [rbp+item]
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+item]
    mov     rax, [rax+8]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+item]
    mov     rdi, rax; ptr
    call    _free
    leave
    retn
item_free endp

