sub_4008C9 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    cmp     [rbp+var_1C], 0
    jg      short loc_4008E5
    mov     eax, 0
    jmp     short locret_40094C
loc_4008E5:
    mov     [rbp+var_8], 0
    jmp     short loc_40092E
loc_4008EE:
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    jle     short loc_400939
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jz      short loc_400939
    add     [rbp+var_8], 1
loc_40092E:
    mov     eax, [rbp+var_1C]
    sub     eax, 1
    cmp     eax, [rbp+var_8]
    jg      short loc_4008EE
loc_400939:
    mov     eax, [rbp+var_8]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, [rbp+var_8]
locret_40094C:
    leave
    retn
sub_4008C9 endp

