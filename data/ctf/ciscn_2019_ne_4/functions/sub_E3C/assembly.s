sub_E3C proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     [rbp+var_18], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, [rbp+var_14]
    cmp     eax, [rbp+var_18]
    jle     short loc_E66
    mov     eax, [rbp+var_18]
    jmp     short loc_E82
loc_E66:
    mov     eax, [rbp+var_18]
    sub     eax, [rbp+var_14]
    cmp     eax, 0Ah
    jnz     short loc_E79
    mov     eax, [rbp+var_14]
    add     eax, 1
    jmp     short loc_E7C
loc_E79:
    mov     eax, [rbp+var_14]
loc_E7C:
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_C]
loc_E82:
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_E96
    call    __stack_chk_fail
locret_E96:
    leave
    retn
sub_E3C endp

