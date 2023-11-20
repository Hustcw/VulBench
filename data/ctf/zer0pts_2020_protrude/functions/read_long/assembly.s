read_long proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 20h ; ' '; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rax, [rbp+s]
    mov     edx, 20h ; ' '; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_34], eax
    cmp     [rbp+var_34], 0
    jnz     short loc_400829
    lea     rdi, s; "[ERROR] read failed"
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_400829:
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    _atol
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400849
    call    ___stack_chk_fail
locret_400849:
    leave
    retn
read_long endp

