main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    mov     [rbp+var_10], rsi
    lea     rdi, aLLL; "/***\n*    |)    |)    |)    \n*    |)L"...
    call    _puts
    mov     eax, 0
    call    sub_E5B
    mov     eax, 0
    call    sub_CC7
    lea     rdi, aHappyShoppingD; "Happy Shopping Day!\nbye~"
    call    _puts
    mov     eax, 0
    leave
    retn
main endp

