sub_AC7 proc
    push    rbp
    mov     rbp, rsp
    mov     [rbp+var_18], rdi
    mov     [rbp+var_2], 0
    jmp     short loc_AE7
loc_AD7:
    mov     rax, [rbp+var_18]
    movzx   eax, word ptr [rax]
    xor     [rbp+var_2], ax
    add     [rbp+var_18], 2
loc_AE7:
    mov     rax, [rbp+var_18]
    movzx   eax, byte ptr [rax]
    test    al, al
    jz      short loc_B01
    mov     rax, [rbp+var_18]
    add     rax, 1
    movzx   eax, byte ptr [rax]
    test    al, al
    jnz     short loc_AD7
loc_B01:
    mov     rax, [rbp+var_18]
    movzx   eax, byte ptr [rax]
    test    al, al
    jz      short loc_B1A
    mov     rax, [rbp+var_18]
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    xor     [rbp+var_2], ax
loc_B1A:
    movzx   eax, [rbp+var_2]
    shr     ax, 5
    xor     ax, [rbp+var_2]
    movzx   edx, [rbp+var_2]
    shr     dx, 0Ah
    xor     eax, edx
    movzx   eax, ax
    and     eax, 1Fh
    pop     rbp
    retn
sub_AC7 endp

