readline proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+buf], rdi
    mov     [rbp+var_1C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, [rbp+var_1C]
    movsxd  rdx, eax; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+buf]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_F45
    sub     [rbp+var_C], 1
loc_F45:
    cmp     [rbp+var_C], 0
    jnz     short loc_F68
    lea     rsi, aReceivedNothin; "Received nothing"
    lea     rdi, aRead; "read"
    call    error
    mov     edi, 1; status
    call    _exit
loc_F68:
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+var_C]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_F8F
    call    ___stack_chk_fail
locret_F8F:
    leave
    retn
readline endp

