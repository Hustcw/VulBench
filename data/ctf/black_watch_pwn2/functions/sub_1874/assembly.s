sub_1874 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    lea     rdi, aPleaseInputThe; "Please input the red packet idx: "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_14F5
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 10h
    ja      short loc_18BD
    mov     eax, [rbp+var_4]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_18C7
loc_18BD:
    mov     eax, 0
    call    sub_1521
loc_18C7:
    mov     eax, [rbp+var_4]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     rax, [rax]
    mov     rdi, rax; s
    call    _puts
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
    leave
    retn
sub_1874 endp

