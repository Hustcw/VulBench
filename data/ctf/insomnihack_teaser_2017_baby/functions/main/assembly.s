main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
    mov     [rbp+var_44], edi
    mov     [rbp+var_50], rsi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     qword ptr [rbp+addr.sa_family], 0
    mov     qword ptr [rbp+addr.sa_data+6], 0
    mov     esi, (offset dword_0+1); handler
    mov     edi, 11h; sig
    call    _signal
    cmp     rax, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_1A6F
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     rcx, rax; s
    mov     edx, 1Eh; n
    mov     esi, 1; size
    lea     rdi, aFailedToSetSig; "Failed to set SIGCHLD handler."
    call    _fwrite
    mov     eax, 1
    jmp     loc_1C16
loc_1A6F:
    mov     edx, 6; protocol
    mov     esi, 1; type
    mov     edi, 2; domain
    call    _socket
    mov     [rbp+fd], eax
    cmp     [rbp+fd], 0FFFFFFFFh
    jnz     short loc_1AA2
    lea     rdi, aSocket_0; "socket"
    call    _perror
    mov     eax, 1
    jmp     loc_1C16
loc_1AA2:
    mov     [rbp+optval], 1
    lea     rdx, [rbp+optval]
    mov     eax, [rbp+fd]
    mov     r8d, 4; optlen
    mov     rcx, rdx; optval
    mov     edx, 2; optname
    mov     esi, 1; level
    mov     edi, eax; fd
    call    _setsockopt
    test    eax, eax
    jz      short loc_1AE4
    lea     rdi, aSetsockopt_0; "setsockopt"
    call    _perror
    mov     eax, 1
    jmp     loc_1C16
loc_1AE4:
    mov     [rbp+addr.sa_family], 2
    mov     edi, 0; hostlong
    call    _htonl
    mov     dword ptr [rbp+addr.sa_data+2], eax
    mov     eax, 539h
    movzx   eax, ax
    mov     edi, eax; hostshort
    call    _htons
    mov     word ptr [rbp+addr.sa_data], ax
    lea     rcx, [rbp+addr]
    mov     eax, [rbp+fd]
    mov     edx, 10h; len
    mov     rsi, rcx; addr
    mov     edi, eax; fd
    call    _bind
    test    eax, eax
    jz      short loc_1B3A
    lea     rdi, aBind_0; "bind"
    call    _perror
    mov     eax, 1
    jmp     loc_1C16
loc_1B3A:
    mov     eax, [rbp+fd]
    mov     esi, 14h; n
    mov     edi, eax; fd
    call    _listen
    test    eax, eax
    jz      short loc_1B63
    lea     rdi, aListen_0; "listen"
    call    _perror
    mov     eax, 1
    jmp     loc_1C16
loc_1B63:
    mov     eax, [rbp+fd]
    mov     edx, 0; addr_len
    mov     esi, 0; addr
    mov     edi, eax; fd
    call    _accept
    mov     [rbp+var_28], eax
    cmp     [rbp+var_28], 0FFFFFFFFh
    jnz     short loc_1B91
    lea     rdi, aAccept_0; "accept"
    call    _perror
    jmp     loc_1C11
loc_1B91:
    call    _fork
    mov     [rbp+var_24], eax
    cmp     [rbp+var_24], 0FFFFFFFFh
    jnz     short loc_1BB7
    lea     rdi, aFork_0; "fork"
    call    _perror
    mov     eax, [rbp+var_28]
    mov     edi, eax; fd
    call    _close
    jmp     short loc_1C11
loc_1BB7:
    cmp     [rbp+var_24], 0
    jnz     short loc_1C07
    mov     edi, 0Fh; seconds
    call    _alarm
    mov     eax, [rbp+fd]
    mov     edi, eax; fd
    call    _close
    lea     rdi, aBaby; "baby"
    call    drop_privs
    mov     [rbp+status], eax
    cmp     [rbp+status], 0
    jnz     short loc_1BF3
    mov     eax, [rbp+var_28]
    mov     edi, eax
    call    handle
    mov     [rbp+status], eax
loc_1BF3:
    mov     eax, [rbp+var_28]
    mov     edi, eax; fd
    call    _close
    mov     eax, [rbp+status]
    mov     edi, eax; status
    call    __exit
loc_1C07:
    mov     eax, [rbp+var_28]
    mov     edi, eax; fd
    call    _close
loc_1C11:
    jmp     loc_1B63
loc_1C16:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_1C2A
    call    ___stack_chk_fail
locret_1C2A:
    leave
    retn
main endp

