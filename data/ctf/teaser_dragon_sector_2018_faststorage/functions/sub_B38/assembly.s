sub_B38 proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_18], rdi
    mov     [rbp+var_4], 0
    mov     [rbp+var_8], 0
    jmp     short loc_B8A
loc_B50:
    mov     [rbp+var_8], 0
    jmp     short loc_B7B
loc_B59:
    mov     rax, [rbp+var_18]
    movzx   eax, byte ptr [rax]
    movzx   edx, al
    mov     eax, [rbp+var_8]
    mov     ecx, eax
    sar     edx, cl
    mov     eax, edx
    and     eax, 1
    test    eax, eax
    jz      short loc_B77
    add     [rbp+var_4], 1
loc_B77:
    add     [rbp+var_8], 1
loc_B7B:
    cmp     [rbp+var_8], 7
    jle     short loc_B59
    add     [rbp+var_18], 1
    and     [rbp+var_4], 1Fh
loc_B8A:
    mov     rax, [rbp+var_18]
    movzx   eax, byte ptr [rax]
    test    al, al
    jnz     short loc_B50
    mov     eax, [rbp+var_4]
    pop     rbp
    retn
sub_B38 endp

