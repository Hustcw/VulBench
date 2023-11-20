sub_40109D proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edi, offset aPleaseEnterThe_1; "Please enter the index: "
    call    sub_400C52
    mov     eax, 0
    call    sub_400C90
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    js      locret_4011E4
    cmp     [rbp+var_4], 0Fh
    jg      locret_4011E4
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:ptr[rax*8]
    test    rax, rax
    jz      locret_4011E4
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:qword_602180[rax*8]
    lea     rdx, [rax-1]
    mov     eax, [rbp+var_4]
    cdqe
    mov     ds:qword_602180[rax*8], rdx
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:ptr[rax*8]
    mov     rdx, [rax]
    sub     rdx, 1
    mov     [rax], rdx
    mov     eax, [rbp+var_4]
    cdqe
    mov     rdx, ds:qword_602180[rax*8]
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:ptr[rax*8]
    mov     rax, [rax]
    cmp     rdx, rax
    jnz     short loc_40116A
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:qword_602180[rax*8]
    test    rax, rax
    jns     loc_4011E3
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:ptr[rax*8]
    mov     rdi, rax; ptr
    call    _free
    jmp     short loc_4011E3
loc_40116A:
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:qword_602180[rax*8]
    test    rax, rax
    jns     short locret_4011E4
    mov     eax, cs:dword_602160
    cdqe
    mov     rax, ds:ptr[rax*8]
    add     rax, 10h
    mov     rsi, rax
    mov     edi, offset aS; "%s"
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
    mov     edi, offset aHasFreed; " has freed"
    call    sub_400C00
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:ptr[rax*8]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_4]
    cdqe
    mov     ds:ptr[rax*8], 0
    jmp     short locret_4011E4
loc_4011E3:
    nop
locret_4011E4:
    leave
    retn
sub_40109D endp

