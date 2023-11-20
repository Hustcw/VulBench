getflag proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:flag
    mov     eax, [rax]
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_D5E
    lea     rdi, aYouAreThinking; "You are thinking peach"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_D5E:
    lea     rdi, command; "/bin/cat flag"
    call    _system
    mov     edi, 0; status
    call    _exit
getflag endp

