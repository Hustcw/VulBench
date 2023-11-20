sub_400932 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     [rbp+var_4], 0
    mov     [rbp+var_4], 0
    jmp     short loc_40099C
loc_400951:
    mov     edx, [rbp+var_4]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     edx, [rbp+var_4]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jz      short loc_400989
    mov     eax, [rbp+var_1C]
    sub     eax, 1
    cmp     [rbp+var_4], eax
    jnz     short loc_400998
loc_400989:
    mov     edx, [rbp+var_4]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_4009A4
loc_400998:
    add     [rbp+var_4], 1
loc_40099C:
    mov     eax, [rbp+var_4]
    cmp     eax, [rbp+var_1C]
    jb      short loc_400951
loc_4009A4:
    nop
    leave
    retn
sub_400932 endp

