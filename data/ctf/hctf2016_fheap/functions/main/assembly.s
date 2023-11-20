main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 410h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    lea     rdi, s; "+++++++++++++++++++++++++++"
    call    _puts
    lea     rdi, aSoLetSCrashThe; "So, let's crash the world"
    call    _puts
    lea     rdi, s; "+++++++++++++++++++++++++++"
    call    _puts
loc_C71:
    call    sub_114B
    lea     rax, [rbp+buf]
    mov     edx, 400h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    test    rax, rax
    jnz     short loc_C9E
    mov     eax, 1
    jmp     loc_D3C
loc_C9E:
    lea     rax, [rbp+buf]
    mov     edx, 7; n
    lea     rsi, s2; "create "
    mov     rdi, rax; s1
    call    _strncmp
    test    eax, eax
    jnz     short loc_CC9
    mov     eax, 0
    call    sub_EC8
    jmp     short loc_D37
loc_CC9:
    lea     rax, [rbp+buf]
    mov     edx, 7; n
    lea     rsi, aDelete; "delete "
    mov     rdi, rax; s1
    call    _strncmp
    test    eax, eax
    jnz     short loc_CF4
    mov     eax, 0
    call    sub_D95
    jmp     short loc_D37
loc_CF4:
    lea     rax, [rbp+buf]
    mov     edx, 5; n
    lea     rsi, aQuit; "quit "
    mov     rdi, rax; s1
    call    _strncmp
    test    eax, eax
    jnz     short loc_D26
    lea     rdi, aBye; "Bye~"
    call    _puts
    mov     eax, 0
    jmp     short loc_D3C
loc_D26:
    lea     rdi, aInvalidCmd; "Invalid cmd"
    call    _puts
    jmp     loc_C71
loc_D37:
    jmp     loc_C71
loc_D3C:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_D50
    call    ___stack_chk_fail
locret_D50:
    leave
    retn
main endp

