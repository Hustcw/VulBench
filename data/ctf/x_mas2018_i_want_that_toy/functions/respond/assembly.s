respond proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
    mov     [rbp+fd], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, 0FFFFh; size
    call    _malloc
    mov     cs:buf, rax
    mov     rsi, cs:buf; buf
    mov     eax, [rbp+fd]
    mov     ecx, 0; flags
    mov     edx, 0FFFFh; n
    mov     edi, eax; fd
    call    _recv
    mov     [rbp+var_3C], eax
    cmp     [rbp+var_3C], 0
    jns     short loc_19D6
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     rcx, rax; s
    mov     edx, 0Dh; n
    mov     esi, 1; size
    lea     rdi, aRecvError; "recv() error\n"
    call    _fwrite
    jmp     loc_1D02
loc_19D6:
    cmp     [rbp+var_3C], 0
    jnz     short loc_1A04
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     rcx, rax; s
    mov     edx, 22h ; '"'; n
    mov     esi, 1; size
    lea     rdi, aClientDisconne; "Client disconnected upexpectedly.\n"
    call    _fwrite
    jmp     loc_1D02
loc_1A04:
    mov     rdx, cs:buf
    mov     eax, [rbp+var_3C]
    cdqe
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     rax, cs:buf
    lea     rsi, asc_215B; " \t\r\n"
    mov     rdi, rax; s
    call    _strtok
    mov     rdx, rax
    lea     rax, method
    mov     [rax], rdx
    lea     rsi, asc_2160; " \t"
    mov     edi, 0; s
    call    _strtok
    mov     rdx, rax
    lea     rax, uri
    mov     [rax], rdx
    lea     rsi, asc_215B; " \t\r\n"
    mov     edi, 0; s
    call    _strtok
    mov     rdx, rax
    lea     rax, prot
    mov     [rax], rdx
    lea     rax, uri
    mov     rcx, [rax]
    lea     rax, method
    mov     rdx, [rax]
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    lea     rsi, a32mSS0m; "\x1B[32m + [%s] %s\x1B[0m\n"
    mov     rdi, rax; stream
    mov     eax, 0
    call    _fprintf
    lea     rax, uri
    mov     rax, [rax]
    mov     esi, 3Fh ; '?'; c
    mov     rdi, rax; s
    call    _strchr
    mov     rdx, rax
    lea     rax, qs
    mov     [rax], rdx
    lea     rax, qs
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_1AF7
    lea     rax, qs
    mov     rax, [rax]
    lea     rcx, [rax+1]
    lea     rdx, qs
    mov     [rdx], rcx
    mov     byte ptr [rax], 0
    jmp     short loc_1B0F
loc_1AF7:
    lea     rax, uri
    mov     rax, [rax]
    lea     rdx, [rax-1]
    lea     rax, qs
    mov     [rax], rdx
loc_1B0F:
    lea     rax, reqhdr
    mov     [rbp+var_38], rax
    jmp     loc_1BEC
loc_1B1F:
    lea     rsi, asc_2178; "\r\n: \t"
    mov     edi, 0; s
    call    _strtok
    mov     [rbp+var_28], rax
    cmp     [rbp+var_28], 0
    jz      loc_1BFF
    lea     rsi, asc_217E; "\r\n"
    mov     edi, 0; s
    call    _strtok
    mov     [rbp+s], rax
    jmp     short loc_1B5B
loc_1B56:
    add     [rbp+s], 1
loc_1B5B:
    mov     rax, [rbp+s]
    movzx   eax, byte ptr [rax]
    test    al, al
    jz      short loc_1B71
    mov     rax, [rbp+s]
    movzx   eax, byte ptr [rax]
    cmp     al, 20h ; ' '
    jz      short loc_1B56
loc_1B71:
    mov     rax, [rbp+var_38]
    mov     rdx, [rbp+var_28]
    mov     [rax], rdx
    mov     rax, [rbp+var_38]
    mov     rdx, [rbp+s]
    mov     [rax+8], rdx
    add     [rbp+var_38], 10h
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     rcx, [rbp+s]
    mov     rdx, [rbp+var_28]
    lea     rsi, aHSS; "[H] %s: %s\n"
    mov     rdi, rax; stream
    mov     eax, 0
    call    _fprintf
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    lea     rdx, [rax+1]
    mov     rax, [rbp+s]
    add     rax, rdx
    mov     [rbp+var_20], rax
    mov     rax, [rbp+var_20]
    add     rax, 1
    movzx   eax, byte ptr [rax]
    cmp     al, 0Dh
    jnz     short loc_1BEC
    mov     rax, [rbp+var_20]
    add     rax, 2
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jz      short loc_1C02
loc_1BEC:
    lea     rax, unk_203180
    cmp     [rbp+var_38], rax
    jb      loc_1B1F
    jmp     short loc_1C03
loc_1BFF:
    nop
    jmp     short loc_1C03
loc_1C02:
    nop
loc_1C03:
    add     [rbp+var_18], 1
    lea     rdi, aContentLength; "Content-Length"
    call    request_header
    mov     [rbp+nptr], rax
    lea     rax, payload
    mov     rdx, [rbp+var_18]
    mov     [rax], rdx
    cmp     [rbp+nptr], 0
    jz      short loc_1C3D
    mov     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atol
    mov     edx, eax
    jmp     short loc_1C55
loc_1C3D:
    mov     eax, [rbp+var_3C]
    mov     rdx, cs:buf
    mov     rcx, [rbp+var_18]
    sub     rcx, rdx
    mov     rdx, rcx
    sub     eax, edx
    mov     edx, eax
loc_1C55:
    lea     rax, payload_size
    mov     [rax], edx
    mov     eax, 0
    call    parse_query_string
    mov     eax, [rbp+fd]
    mov     cs:clientfd, eax
    mov     eax, cs:clientfd
    mov     esi, 1; fd2
    mov     edi, eax; fd
    call    _dup2
    mov     eax, cs:clientfd
    mov     esi, 2; fd2
    mov     edi, eax; fd
    call    _dup2
    mov     eax, cs:clientfd
    mov     edi, eax; fd
    call    _close
    mov     eax, 0
    call    route
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    mov     esi, 1; how
    mov     edi, 1; fd
    call    _shutdown
    mov     esi, 1; how
    mov     edi, 2; fd
    call    _shutdown
    mov     edi, 1; fd
    call    _close
    mov     edi, 1; fd
    call    _close
loc_1D02:
    mov     eax, cs:clientfd
    mov     esi, 2; how
    mov     edi, eax; fd
    call    _shutdown
    mov     eax, cs:clientfd
    mov     edi, eax; fd
    call    _close
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1D36
    call    ___stack_chk_fail
locret_1D36:
    leave
    retn
respond endp

