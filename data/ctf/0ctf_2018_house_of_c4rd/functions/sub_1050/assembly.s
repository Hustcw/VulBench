sub_1050 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    mov     [rbp+fd], edi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_28], rdx
    mov     [rbp+var_38], 0
loc_1078:
    mov     rax, [rbp+var_38]
    cmp     rax, [rbp+var_28]
    jnb     loc_1118
    mov     eax, 1
    mov     edx, eax; nbytes
    mov     edi, [rbp+fd]; fd
    mov     rcx, [rbp+var_20]
    add     rcx, [rbp+var_38]
    mov     rsi, rcx; buf
    call    _read
    mov     [rbp+var_30], rax
    cmp     [rbp+var_30], 0FFFFFFFFFFFFFFFFh
    jnz     loc_10DD
    call    ___errno_location
    cmp     dword ptr [rax], 0Bh
    jz      loc_10CB
    call    ___errno_location
    cmp     dword ptr [rax], 4
    jnz     loc_10D0
loc_10CB:
    jmp     loc_1078
loc_10D0:
    mov     [rbp+var_10], 0FFFFFFFFFFFFFFFFh
    jmp     loc_1120
loc_10DD:
    cmp     [rbp+var_30], 0
    jnz     loc_10ED
    jmp     loc_1118
loc_10ED:
    mov     rax, [rbp+var_20]
    mov     rcx, [rbp+var_38]
    movsx   edx, byte ptr [rax+rcx]
    cmp     edx, 0Ah
    jnz     loc_1107
    jmp     loc_1118
loc_1107:
    mov     rax, [rbp+var_30]
    add     rax, [rbp+var_38]
    mov     [rbp+var_38], rax
    jmp     loc_1078
loc_1118:
    mov     rax, [rbp+var_38]
    mov     [rbp+var_10], rax
loc_1120:
    mov     rax, [rbp+var_10]
    mov     rcx, fs:28h
    mov     rdx, [rbp+var_8]
    cmp     rcx, rdx
    mov     [rbp+var_40], rax
    jnz     loc_1148
    mov     rax, [rbp+var_40]
    add     rsp, 40h
    pop     rbp
    retn
loc_1148:
    call    ___stack_chk_fail
sub_1050 endp

