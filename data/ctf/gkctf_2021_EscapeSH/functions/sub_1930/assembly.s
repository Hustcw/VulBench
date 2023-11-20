sub_1930 proc
    push    r12
    lea     r12, unk_205B40
    push    rbp
    push    rbx
    cmp     dword ptr [r12], 1
    jle     short loc_1992
    lea     rax, unk_204040
    mov     ebp, 1
    lea     rbx, [rax+8]
    jmp     short loc_1978
loc_1958:
    lea     rsi, aS; "%s "
    xor     eax, eax
    mov     edi, 1
    add     ebp, 1
    add     rbx, 8
    call    __printf_chk
    cmp     [r12], ebp
    jle     short loc_1992
loc_1978:
    mov     rdx, [rbx]
    cmp     byte ptr [rdx], 3Eh ; '>'
    jnz     short loc_1958
    movzx   eax, byte ptr [rdx+1]
    test    al, al
    jz      short loc_1992
    cmp     al, 3Eh ; '>'
    jnz     short loc_1958
    cmp     byte ptr [rdx+2], 0
    jnz     short loc_1958
loc_1992:
    pop     rbx
    pop     rbp
    pop     r12
    mov     edi, 0Ah; c
    jmp     putchar
sub_1930 endp

