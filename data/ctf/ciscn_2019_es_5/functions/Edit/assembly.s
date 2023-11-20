Edit proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    lea     rdi, aIndex; "Index:"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    read_int
    mov     [rbp+var_14], eax
    cmp     [rbp+var_14], 0
    js      short loc_D30
    cmp     [rbp+var_14], 9
    jle     short loc_D46
loc_D30:
    lea     rdi, aYouWantToSteal; "You want to steal the flag?"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_D46:
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, flist
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      loc_E36
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, flist
    mov     rax, [rdx+rax]
    mov     [rbp+var_10], rax
    mov     rax, [rbp+var_10]
    mov     eax, [rax+0Ch]
    test    eax, eax
    jnz     short loc_DA4
    lea     rdi, aDead; "Dead!"
    call    _puts
    mov     eax, 0
    jmp     locret_E47
loc_DA4:
    mov     rax, [rbp+var_10]
    mov     eax, [rax+0Ch]
    lea     edx, [rax-1]
    mov     rax, [rbp+var_10]
    mov     [rax+0Ch], edx
    mov     rax, [rbp+var_10]
    mov     eax, [rax+8]
    movsxd  rdx, eax
    mov     rax, [rbp+var_10]
    mov     rax, [rax]
    mov     rsi, rdx; size
    mov     rdi, rax; ptr
    call    _realloc
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0
    jz      short loc_E23
    mov     rax, [rbp+var_10]
    mov     rdx, [rbp+var_8]
    mov     [rax], rdx
    lea     rdi, aNewContent; "New content:"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+var_10]
    mov     edx, [rax+8]
    mov     rax, [rbp+var_10]
    mov     rax, [rax]
    mov     esi, edx
    mov     rdi, rax
    call    secure_read
    lea     rdi, aOk; "OK!"
    call    _puts
    mov     eax, 0
    jmp     short locret_E47
loc_E23:
    lea     rdi, aCanNotEditThis; "Can not edit this flag!"
    call    _puts
    mov     eax, 0
    jmp     short locret_E47
loc_E36:
    lea     rdi, aNoneFlag; "None flag!"
    call    _puts
    mov     eax, 0
locret_E47:
    leave
    retn
Edit endp

