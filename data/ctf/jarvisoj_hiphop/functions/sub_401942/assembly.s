sub_401942 proc
    push    rbp
    mov     rbp, rsp
    add     rsp, 0FFFFFFFFFFFFFF80h
    mov     [rbp+var_78], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aContent; "content:"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_70]
    mov     rsi, rax
    mov     edi, offset aS; "%s"
    mov     eax, 0
    call    _scanf
    mov     edi, offset aOkThanks; "ok, thanks."
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_4019A1
    call    ___stack_chk_fail
locret_4019A1:
    leave
    retn
sub_401942 endp

