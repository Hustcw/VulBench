Show proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, aIndex; "Index:"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    read_int
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 0
    js      short loc_E7B
    cmp     [rbp+var_C], 9
    jle     short loc_E91
loc_E7B:
    lea     rdi, aYouWantToSteal; "You want to steal the flag?"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_E91:
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, flist
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      loc_F34
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, flist
    mov     rax, [rdx+rax]
    mov     [rbp+var_8], rax
    mov     rax, [rbp+var_8]
    mov     eax, [rax+0Ch]
    test    eax, eax
    jnz     short loc_EE7
    lea     rdi, aDeadFlag; "Dead flag!"
    call    _puts
    jmp     short locret_F41
loc_EE7:
    mov     eax, [rbp+var_C]
    mov     esi, eax
    lea     rdi, aFlagOfIndexD; "Flag of index %d:\n"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+var_8]
    mov     ecx, [rax+0Ch]
    mov     rax, [rbp+var_8]
    mov     edx, [rax+8]
    mov     rax, [rbp+var_8]
    mov     rax, [rax]
    mov     rsi, rax
    lea     rdi, aContentSSizeDs; "Content: %s\nSize: %dsState: %d\n"
    mov     eax, 0
    call    _printf
    lea     rdi, aDone; "Done!"
    call    _puts
    jmp     short locret_F41
loc_F34:
    lea     rdi, aNoneFlag; "None flag!"
    call    _puts
    nop
locret_F41:
    leave
    retn
Show endp

