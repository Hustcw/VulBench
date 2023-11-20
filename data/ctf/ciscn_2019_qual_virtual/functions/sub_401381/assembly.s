sub_401381 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+ptr], rdi
    cmp     [rbp+ptr], 0
    jz      short loc_4013B1
    mov     rax, [rbp+ptr]
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    jmp     short locret_4013B2
loc_4013B1:
    nop
locret_4013B2:
    leave
    retn
sub_401381 endp

