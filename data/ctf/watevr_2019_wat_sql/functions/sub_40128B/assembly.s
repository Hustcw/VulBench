sub_40128B proc
    push    rbp
    mov     rbp, rsp
    lea     rsi, aDemoActivation; "Demo activation code: "
    lea     rdi, aS; "%s"
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
    mov     rax, cs:stdin
    mov     rdx, cs:s2
    mov     rcx, rdx
    mov     rdx, rax; stream
    mov     esi, 24h ; '$'; n
    mov     rdi, rcx; s
    call    _fgets
    mov     rax, cs:s2
    mov     rsi, rax; s2
    lea     rdi, s1; "watevr-sql2019-demo-code-admin"
    call    _strcmp
    test    eax, eax
    jnz     short loc_401310
    mov     rax, cs:s2
    mov     eax, [rax+20h]
    cmp     eax, 796573h
    jnz     short loc_401310
    lea     rdi, aDemoAccessGran; "Demo access granted!"
    call    _puts
    jmp     short loc_40131C
loc_401310:
    lea     rdi, aDemoAccessNotG; "Demo access not granted!"
    call    _puts
loc_40131C:
    nop
    pop     rbp
    retn
sub_40128B endp

