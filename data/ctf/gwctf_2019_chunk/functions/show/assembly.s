show proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWhichBookDoYou; "Which book do you want to show?"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+nptr]
    mov     esi, 10h
    mov     rdi, rax
    mov     eax, 0
    call    read_0
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    atoi
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, chunk
    mov     rax, [rdx+rax]
    mov     rsi, rax
    lea     rdi, aContentS; "Content: %s"
    mov     eax, 0
    call    printf
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_EAB
    call    __stack_chk_fail
locret_EAB:
    leave
    retn
show endp

