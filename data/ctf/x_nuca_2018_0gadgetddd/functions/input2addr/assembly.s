input2addr proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    jmp     short loc_4009D3
loc_40096E:
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    test    rax, rax
    jns     short loc_400993
    mov     edi, 1; status
    call    _exit
loc_400993:
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rdx, rax
    movzx   eax, [rbp+buf]
    mov     [rdx], al
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_4009CF
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+var_C]
    jmp     short loc_4009DE
loc_4009CF:
    add     [rbp+var_C], 1
loc_4009D3:
    mov     eax, [rbp+var_C]
    cmp     eax, [rbp+var_1C]
    jle     short loc_40096E
    mov     eax, [rbp+var_C]
loc_4009DE:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_4009F2
    call    ___stack_chk_fail
locret_4009F2:
    leave
    retn
input2addr endp

