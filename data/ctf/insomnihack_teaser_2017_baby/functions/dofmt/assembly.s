dofmt proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 430h
    mov     [rbp+fd], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_414], 0
    mov     eax, [rbp+fd]
    lea     rsi, aSimplyTypeNToR; "Simply type '\\n' to return\n"
    mov     edi, eax
    call    sendstr
loc_1506:
    mov     eax, [rbp+fd]
    lea     rsi, aYourFormat; "Your format > "
    mov     edi, eax
    call    sendstr
    lea     rsi, [rbp+s]
    mov     eax, [rbp+fd]
    lea     rcx, asc_1D3B; "\n"
    mov     edx, 400h
    mov     edi, eax
    call    recvlen_until
    mov     [rbp+var_414], eax
    cmp     [rbp+var_414], 1
    jnz     short loc_1560
    nop
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_15BE
    jmp     short loc_15B9
loc_1560:
    mov     eax, [rbp+var_414]
    mov     esi, eax
    lea     rdi, aD; "%d\n"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+s]
    mov     rdi, rax; s
    call    _puts
    mov     eax, [rbp+var_414]
    cdqe
    mov     [rbp+rax+s], 0
    lea     rdx, [rbp+s]
    mov     eax, [rbp+fd]
    mov     rsi, rdx; fmt
    mov     edi, eax; fd
    mov     eax, 0
    call    _dprintf
    jmp     loc_1506
loc_15B9:
    call    ___stack_chk_fail
locret_15BE:
    leave
    retn
dofmt endp

