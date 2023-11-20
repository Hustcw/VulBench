sub_1350 proc
    push    r12
    push    rbp
    push    rbx
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rsp+28h+var_20], rax
    xor     eax, eax
    test    esi, esi
    jle     short loc_13B8
    lea     eax, [rsi-1]
    mov     rbx, rdi
    lea     rbp, [rsp+28h+buf]
    lea     r12, [rdi+rax+1]
    jmp     short loc_1394
loc_1380:
    movzx   eax, [rsp+28h+buf]
    mov     [rbx], al
    cmp     al, 0Ah
    jz      short loc_13B8
    add     rbx, 1
    cmp     rbx, r12
    jz      short loc_13B8
loc_1394:
    xor     edi, edi; fd
    mov     edx, 1; nbytes
    mov     rsi, rbp; buf
    mov     [rsp+28h+buf], 0
    call    _read
    test    rax, rax
    jg      short loc_1380
    xor     edi, edi; status
    call    _exit
loc_13B8:
    mov     rax, [rsp+28h+var_20]
    xor     rax, fs:28h
    jnz     short loc_13D1
    add     rsp, 10h
    pop     rbx
    pop     rbp
    pop     r12
    retn
loc_13D1:
    call    ___stack_chk_fail
sub_1350 endp

