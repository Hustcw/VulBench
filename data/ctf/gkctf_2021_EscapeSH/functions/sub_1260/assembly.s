sub_1260 proc
    push    r15
    push    r14
    lea     rsi, aClear+4; modes
    push    r13
    push    r12
    push    rbp
    push    rbx
    sub     rsp, 418h
    lea     r15, unk_204040
    mov     rax, fs:28h
    mov     [rsp+448h+var_40], rax
    xor     eax, eax
    mov     rdi, [r15+8]; filename
    call    fopen
    test    rax, rax
    jz      loc_139F
    mov     r12, rax
    xor     r13d, r13d
    xor     r14d, r14d
    xor     ebx, ebx
    mov     rbp, rsp
    nop     word ptr [rax+rax+00h]
loc_12B8:
    mov     rdx, r12; stream
    mov     esi, 400h; n
    mov     rdi, rbp; s
    call    fgets
    test    rax, rax
    jz      short loc_134B
    mov     rax, rbp
loc_12D0:
    mov     ecx, [rax]
    add     rax, 4
    lea     edx, [rcx-1010101h]
    not     ecx
    and     edx, ecx
    and     edx, 80808080h
    jz      short loc_12D0
    mov     ecx, edx
    lea     rsi, aS+2; delim
    mov     rdi, rbp; s
    shr     ecx, 10h
    test    edx, 8080h
    cmovz   edx, ecx
    lea     rcx, [rax+2]
    cmovz   rax, rcx
    mov     ecx, edx
    add     cl, dl
    sbb     rax, 3
    add     r13d, 1
    sub     rax, rbp
    add     r14d, eax
    sub     eax, 1
    cdqe
    mov     [rsp+rax+448h+var_448], 0
    call    strtok
    test    rax, rax
    jz      short loc_12B8
    nop     dword ptr [rax]
loc_1330:
    lea     rsi, aS+2; delim
    xor     edi, edi; s
    add     ebx, 1
    call    strtok
    test    rax, rax
    jnz     short loc_1330
    jmp     loc_12B8
loc_134B:
    mov     r9, [r15+8]
    lea     rsi, aDDDS; "%d\t%d\t%d %s"
    mov     r8d, r14d
    mov     ecx, ebx
    mov     edx, r13d
    mov     edi, 1
    call    __printf_chk
    mov     edi, 0Ah; c
    call    putchar
    mov     rdi, r12; stream
    call    fclose
loc_137A:
    mov     rax, [rsp+448h+var_40]
    xor     rax, fs:28h
    jnz     short loc_13AD
    add     rsp, 418h
    pop     rbx
    pop     rbp
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    retn
loc_139F:
    lea     rdi, aOpenFalse; "open false!"
    call    puts
    jmp     short loc_137A
loc_13AD:
    call    __stack_chk_fail
sub_1260 endp

