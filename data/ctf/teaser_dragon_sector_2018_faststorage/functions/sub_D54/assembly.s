sub_D54 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+s2], rdi
    mov     rax, [rbp+s2]
    mov     rdi, rax
    call    sub_A8A
    mov     [rbp+var_C], eax
    mov     rax, [rbp+s2]
    mov     rdi, rax
    call    sub_AC7
    mov     [rbp+var_10], eax
    mov     rax, [rbp+s2]
    mov     rdi, rax
    call    sub_B38
    mov     [rbp+var_14], eax
    mov     [rbp+var_8], 0
    mov     eax, [rbp+var_C]
    sar     eax, 1Fh
    mov     ecx, eax
    xor     ecx, [rbp+var_C]
    sub     ecx, eax
    mov     edx, 84210843h
    mov     eax, ecx
    imul    edx
    lea     eax, [rdx+rcx]
    sar     eax, 5
    mov     edx, eax
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_C]
    imul    eax, 3Eh ; '>'
    sub     ecx, eax
    mov     eax, ecx
    mov     [rbp+var_C], eax
    mov     edx, [rbp+var_14]
    mov     ecx, [rbp+var_10]
    mov     eax, [rbp+var_C]
    mov     esi, ecx
    mov     edi, eax
    call    sub_C64
    test    eax, eax
    jnz     short loc_DE9
    mov     eax, 0
    jmp     short locret_E38
loc_DE9:
    lea     rax, qword_202140
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     [rbp+var_8], rax
    jmp     short loc_E26
loc_E00:
    mov     rax, [rbp+var_8]
    mov     rax, [rax+8]
    mov     rdx, [rbp+s2]
    mov     rsi, rdx; s2
    mov     rdi, rax; s1
    call    strcmp
    test    eax, eax
    jz      short loc_E2F
    mov     rax, [rbp+var_8]
    mov     rax, [rax]
    mov     [rbp+var_8], rax
loc_E26:
    cmp     [rbp+var_8], 0
    jnz     short loc_E00
    jmp     short loc_E30
loc_E2F:
    nop
loc_E30:
    mov     rax, [rbp+var_8]
    mov     rax, [rax+10h]
locret_E38:
    leave
    retn
sub_D54 endp

