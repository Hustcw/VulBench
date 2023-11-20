sub_A8A proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_18], rdi
    mov     [rbp+var_4], 1337h
    jmp     short loc_AB7
loc_A9B:
    mov     rax, [rbp+var_18]
    lea     rdx, [rax+1]
    mov     [rbp+var_18], rdx
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    imul    eax, [rbp+var_4]
    add     eax, 1
    mov     [rbp+var_4], eax
loc_AB7:
    mov     rax, [rbp+var_18]
    movzx   eax, byte ptr [rax]
    test    al, al
    jnz     short loc_A9B
    mov     eax, [rbp+var_4]
    pop     rbp
    retn
sub_A8A endp

