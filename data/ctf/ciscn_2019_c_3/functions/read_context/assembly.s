read_context proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     [rbp+var_4], 0
loc_CC6:
    mov     edx, [rbp+var_4]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    cmp     rax, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_CF2
    mov     edi, 0; status
    call    _exit
loc_CF2:
    mov     edx, [rbp+var_4]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_D12
    mov     edx, [rbp+var_4]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short locret_D30
loc_D12:
    add     [rbp+var_4], 1
    mov     eax, [rbp+var_4]
    cmp     eax, [rbp+var_1C]
    jb      short loc_CC6
    mov     eax, [rbp+var_4]
    sub     eax, 1
    mov     edx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
locret_D30:
    leave
    retn
read_context endp

