sub_B65 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_24], 0
    jmp     short loc_B96
loc_B85:
    movzx   edx, [rbp+buf]
    mov     eax, [rbp+var_24]
    cdqe
    mov     [rbp+rax+nptr], dl
    add     [rbp+var_24], 1
loc_B96:
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    movzx   eax, [rbp+buf]
    cmp     al, 0Ah
    jz      short loc_BC2
    cmp     [rbp+var_24], 9
    jg      short loc_BC2
    movzx   eax, [rbp+buf]
    cmp     al, 0FFh
    jnz     short loc_B85
loc_BC2:
    mov     eax, [rbp+var_24]
    cdqe
    mov     [rbp+rax+nptr], 0
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_BEC
    call    ___stack_chk_fail
locret_BEC:
    leave
    retn
sub_B65 endp

