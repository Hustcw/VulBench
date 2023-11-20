sub_CB6 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    sub_A8A
    mov     [rbp+var_4], eax
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    sub_AC7
    mov     [rbp+var_8], eax
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    sub_B38
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_4]
    sar     eax, 1Fh
    mov     ecx, eax
    xor     ecx, [rbp+var_4]
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
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_4]
    imul    eax, 3Eh ; '>'
    sub     ecx, eax
    mov     eax, ecx
    mov     [rbp+var_4], eax
    mov     rdx, [rbp+var_20]
    mov     rcx, [rbp+var_18]
    mov     eax, [rbp+var_4]
    mov     rsi, rcx
    mov     edi, eax
    call    sub_B9A
    mov     edx, [rbp+var_C]
    mov     ecx, [rbp+var_8]
    mov     eax, [rbp+var_4]
    mov     esi, ecx
    mov     edi, eax
    call    sub_C14
    nop
    leave
    retn
sub_CB6 endp

