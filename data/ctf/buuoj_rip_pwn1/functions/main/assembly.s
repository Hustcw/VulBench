main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, s; "please input"
    call    _puts
    lea     rax, [rbp+s]
    mov     rdi, rax
    mov     eax, 0
    call    _gets
    lea     rax, [rbp+s]
    mov     rdi, rax; s
    call    _puts
    lea     rdi, aOkBye; "ok,bye!!!"
    call    _puts
    mov     eax, 0
    leave
    retn
main endp

