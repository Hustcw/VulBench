print_hex proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+buf], rdi
    mov     [rbp+buflen], rsi
    mov     [rbp+i], 0
    jmp     short loc_1A82
loc_1A55:
    mov     eax, [rbp+i]
    movsxd  rdx, eax
    mov     rax, [rbp+buf]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
    movzx   eax, al
    mov     esi, eax
    lea     rdi, a02x; "%02x"
    mov     eax, 0
    call    _printf
    add     [rbp+i], 1
loc_1A82:
    mov     eax, [rbp+i]
    cdqe
    cmp     [rbp+buflen], rax
    ja      short loc_1A55
    mov     edi, 0Ah; c
    call    _putchar
    nop
    leave
    retn
print_hex endp

