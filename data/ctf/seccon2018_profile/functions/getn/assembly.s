getn proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
loc_4014B3:
    mov     eax, [rbp+var_C]
    cmp     eax, [rbp+var_1C]
    jnb     short loc_4014F0
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    movzx   eax, [rbp+buf]
    cmp     al, 0Ah
    jz      short loc_4014EF
    mov     edx, [rbp+var_C]
    mov     rax, [rbp+var_18]
    add     rdx, rax
    movzx   eax, [rbp+buf]
    mov     [rdx], al
    add     [rbp+var_C], 1
    jmp     short loc_4014B3
loc_4014EF:
    nop
loc_4014F0:
    mov     eax, [rbp+var_C]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_401507
    call    ___stack_chk_fail
locret_401507:
    leave
    retn
getn endp

