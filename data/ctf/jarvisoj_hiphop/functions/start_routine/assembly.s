start_routine proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     edi, offset unk_6033A0
    call    sub_401580
    nop
    leave
    retn
start_routine endp

