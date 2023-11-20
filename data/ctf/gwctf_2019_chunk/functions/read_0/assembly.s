read_0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     [rbp+var_38], rdi
    mov     [rbp+var_3C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_28], 0
loc_F85:
    mov     eax, [rbp+var_28]
    mov     [rbp+var_24], eax
    mov     eax, [rbp+var_28]
    cmp     eax, [rbp+var_3C]
    jge     short loc_FCF
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    mov     eax, 0
    call    read
    movzx   eax, [rbp+buf]
    cmp     al, 0Ah
    jz      short loc_FD2
    mov     eax, [rbp+var_28]
    movsxd  rdx, eax
    mov     rax, [rbp+var_38]
    add     rdx, rax
    movzx   eax, [rbp+buf]
    mov     [rdx], al
    add     [rbp+var_28], 1
    jmp     short loc_F85
loc_FCF:
    nop
    jmp     short loc_FD3
loc_FD2:
    nop
loc_FD3:
    mov     eax, [rbp+var_28]
    movsxd  rdx, eax
    mov     rax, [rbp+var_38]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+var_24]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_FFA
    call    __stack_chk_fail
locret_FFA:
    leave
    retn
read_0 endp

