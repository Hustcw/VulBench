drop_privs proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+name], rdi
    mov     rax, [rbp+name]
    mov     rdi, rax; name
    call    _getpwnam
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0
    jnz     short loc_116F
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     rdx, [rbp+name]
    lea     rsi, format; "User %s not found\n"
    mov     rdi, rax; stream
    mov     eax, 0
    call    _fprintf
    mov     eax, 1
    jmp     locret_1210
loc_116F:
    mov     rax, [rbp+var_8]
    mov     rax, [rax+20h]
    mov     rdi, rax; path
    call    _chdir
    test    eax, eax
    jz      short loc_1196
    lea     rdi, s; "chdir"
    call    _perror
    mov     eax, 1
    jmp     short locret_1210
loc_1196:
    mov     esi, 0; groups
    mov     edi, 0; n
    mov     eax, 0
    call    _setgroups
    test    eax, eax
    jz      short loc_11C1
    lea     rdi, aSetgroups_0; "setgroups"
    call    _perror
    mov     eax, 1
    jmp     short locret_1210
loc_11C1:
    mov     rax, [rbp+var_8]
    mov     eax, [rax+14h]
    mov     edi, eax; gid
    call    _setgid
    test    eax, eax
    jz      short loc_11E6
    lea     rdi, aSetgid_0; "setgid"
    call    _perror
    mov     eax, 1
    jmp     short locret_1210
loc_11E6:
    mov     rax, [rbp+var_8]
    mov     eax, [rax+10h]
    mov     edi, eax; uid
    call    _setuid
    test    eax, eax
    jz      short loc_120B
    lea     rdi, aSetuid_0; "setuid"
    call    _perror
    mov     eax, 1
    jmp     short locret_1210
loc_120B:
    mov     eax, 0
locret_1210:
    leave
    retn
drop_privs endp

