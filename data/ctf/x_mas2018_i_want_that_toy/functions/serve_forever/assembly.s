serve_forever proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     [rbp+var_38], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, [rbp+var_38]
    mov     rdi, rax
    call    startServer
    mov     esi, (offset dword_0+1); handler
    mov     edi, 11h; sig
    call    _signal
loc_1190:
    mov     [rbp+addr_len], 10h
    mov     eax, cs:listenfd
    lea     rdx, [rbp+addr_len]; addr_len
    lea     rcx, [rbp+addr]
    mov     rsi, rcx; addr
    mov     edi, eax; fd
    call    _accept
    mov     [rbp+fd], eax
    cmp     [rbp+fd], 0
    jns     short loc_11C6
    lea     rdi, aAcceptError; "accept() error"
    call    _perror
    jmp     short loc_1190
loc_11C6:
    call    _fork
    test    eax, eax
    jnz     short loc_11E3
    mov     eax, [rbp+fd]
    mov     edi, eax
    call    respond
    mov     edi, 0; status
    call    _exit
loc_11E3:
    mov     eax, [rbp+fd]
    mov     edi, eax; fd
    call    _close
    jmp     short loc_1190
serve_forever endp

