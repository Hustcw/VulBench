startServer proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 70h
    mov     [rbp+service], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 30h ; '0'; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     [rbp+var_3C], 2
    mov     [rbp+var_38], 1
    mov     [rbp+s], 1
    lea     rcx, [rbp+pai]; pai
    lea     rdx, [rbp+s]; req
    mov     rax, [rbp+service]
    mov     rsi, rax; service
    mov     edi, 0; name
    call    _getaddrinfo
    test    eax, eax
    jz      short loc_1268
    lea     rdi, aGetaddrinfoErr; "getaddrinfo() error"
    call    _perror
    mov     edi, 1; status
    call    _exit
loc_1268:
    mov     rax, [rbp+pai]
    mov     [rbp+var_48], rax
    jmp     loc_12FF
loc_1275:
    mov     [rbp+optval], 1
    mov     rax, [rbp+var_48]
    mov     ecx, [rax+8]
    mov     rax, [rbp+var_48]
    mov     eax, [rax+4]
    mov     edx, 0; protocol
    mov     esi, ecx; type
    mov     edi, eax; domain
    call    _socket
    mov     cs:listenfd, eax
    mov     eax, cs:listenfd
    lea     rdx, [rbp+optval]
    mov     r8d, 4; optlen
    mov     rcx, rdx; optval
    mov     edx, 2; optname
    mov     esi, 1; level
    mov     edi, eax; fd
    call    _setsockopt
    mov     eax, cs:listenfd
    cmp     eax, 0FFFFFFFFh
    jz      short loc_12F2
    mov     rax, [rbp+var_48]
    mov     edx, [rax+10h]; len
    mov     rax, [rbp+var_48]
    mov     rcx, [rax+18h]
    mov     eax, cs:listenfd
    mov     rsi, rcx; addr
    mov     edi, eax; fd
    call    _bind
    test    eax, eax
    jz      short loc_130C
    jmp     short loc_12F3
loc_12F2:
    nop
loc_12F3:
    mov     rax, [rbp+var_48]
    mov     rax, [rax+28h]
    mov     [rbp+var_48], rax
loc_12FF:
    cmp     [rbp+var_48], 0
    jnz     loc_1275
    jmp     short loc_130D
loc_130C:
    nop
loc_130D:
    cmp     [rbp+var_48], 0
    jnz     short loc_132A
    lea     rdi, aSocketOrBind; "socket() or bind()"
    call    _perror
    mov     edi, 1; status
    call    _exit
loc_132A:
    mov     rax, [rbp+pai]
    mov     rdi, rax; ai
    call    _freeaddrinfo
    mov     eax, cs:listenfd
    mov     esi, 0F4240h; n
    mov     edi, eax; fd
    call    _listen
    test    eax, eax
    jz      short loc_1362
    lea     rdi, aListenError; "listen() error"
    call    _perror
    mov     edi, 1; status
    call    _exit
loc_1362:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1377
    call    ___stack_chk_fail
locret_1377:
    leave
    retn
startServer endp

