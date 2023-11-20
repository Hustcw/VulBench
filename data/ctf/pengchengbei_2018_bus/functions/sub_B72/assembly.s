sub_B72 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_8], 0
    jmp     short loc_BD0
loc_B8C:
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_8]
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_8]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_BCB
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_8]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_BDE
loc_BCB:
    add     [rbp+var_8], 1
loc_BD0:
    mov     rax, [rbp+var_20]
    sub     rax, 1
    cmp     [rbp+var_8], rax
    jb      short loc_B8C
loc_BDE:
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_8]
    add     rax, rdx
    mov     byte ptr [rax], 0
    nop
    leave
    retn
sub_B72 endp

