sub_1249 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    jmp     short loc_12BC
loc_1270:
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_12B8
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+var_C]
    jmp     short loc_12D6
loc_12B8:
    add     [rbp+var_C], 1
loc_12BC:
    mov     eax, [rbp+var_C]
    cmp     eax, [rbp+var_1C]
    jl      short loc_1270
    mov     rax, cs:stdin
    mov     rdi, rax; stream
    call    _fflush
    mov     eax, [rbp+var_1C]
loc_12D6:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_12EA
    call    ___stack_chk_fail
locret_12EA:
    leave
    retn
sub_1249 endp

