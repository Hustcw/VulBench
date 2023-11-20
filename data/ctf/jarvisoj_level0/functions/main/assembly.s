main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    mov     [rbp+var_10], rsi
    mov     edx, 0Dh; n
    mov     esi, offset aHelloWorld; "Hello, World\n"
    mov     edi, 1; fd
    call    _write
    mov     eax, 0
    call    vulnerable_function
    leave
    retn
main endp

