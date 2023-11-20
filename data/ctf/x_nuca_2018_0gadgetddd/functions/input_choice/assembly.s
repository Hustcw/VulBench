input_choice proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 10h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rax, [rbp+s]
    mov     edx, 10h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_24], eax
    cmp     [rbp+var_24], 0
    jns     short loc_400A4A
    mov     edi, 1; status
    call    _exit
loc_400A4A:
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    _atoi
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400A6A
    call    ___stack_chk_fail
locret_400A6A:
    leave
    retn
input_choice endp

