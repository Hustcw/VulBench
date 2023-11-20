sub_16E8 proc
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
    ja      short loc_1731
    mov     eax, [rbp+var_4]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_173B
loc_1731:
    mov     eax, 0
    call    sub_1521
loc_173B:
    mov     eax, [rbp+var_4]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
    leave
    retn
sub_16E8 endp

