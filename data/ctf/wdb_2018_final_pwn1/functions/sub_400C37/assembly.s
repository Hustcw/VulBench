sub_400C37 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+n+4], rdi
    mov     dword ptr [rbp+n], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    mov     edx, dword ptr [rbp+n]; n
    mov     rax, [rbp+n+4]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     [rbp+var_C], 0
    jmp     short loc_400CB8
loc_400C79:
    mov     [rbp+buf], 0
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    cmp     rax, 1
    jnz     short loc_400CC7
    movzx   eax, [rbp+buf]
    cmp     al, 0Ah
    jz      short loc_400CCA
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+n+4]
    add     rdx, rax
    movzx   eax, [rbp+buf]
    mov     [rdx], al
    add     [rbp+var_C], 1
loc_400CB8:
    mov     eax, dword ptr [rbp+n]
    lea     edx, [rax-1]
    mov     eax, [rbp+var_C]
    cmp     edx, eax
    ja      short loc_400C79
    jmp     short loc_400CCB
loc_400CC7:
    nop
    jmp     short loc_400CCB
loc_400CCA:
    nop
loc_400CCB:
    mov     eax, dword ptr [rbp+n]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400CE2
    call    ___stack_chk_fail
locret_400CE2:
    leave
    retn
sub_400C37 endp

