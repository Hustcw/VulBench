sub_19A0 proc
    push    r15
    push    r14
    mov     esi, 300h; size
    push    r13
    push    r12
    push    rbp
    push    rbx
    sub     rsp, 6A8h
    lea     rbx, [rsp+6D8h+buf]
    mov     rax, fs:28h
    mov     [rsp+6D8h+var_40], rax
    xor     eax, eax
    mov     rdi, rbx; buf
    call    getcwd
    test    rax, rax
    jz      loc_1B60
loc_19E2:
    lea     rax, qword_204040
    mov     rdi, [rax+8]; name
    test    rdi, rdi
    jz      loc_1B50
    call    opendir
    test    rax, rax
    mov     r13, rax
    jz      loc_1B71
loc_1A07:
    lea     rbp, [rsp+6D8h+filename]
    xor     r12d, r12d
    xor     ebx, ebx
    mov     r14, rsp
    nop     word ptr [rax+rax+00000000h]
loc_1A20:
    mov     rdi, r13; dirp
    call    readdir
    test    rax, rax
    jz      loc_1AB0
loc_1A31:
    lea     r15, [rax+13h]
    mov     edx, 300h
    mov     rdi, rbp
    mov     rsi, r15
    call    __strcpy_chk
    cmp     [rsp+6D8h+filename], 2Eh ; '.'
    jz      short loc_1A20
    mov     rdx, r14; stat_buf
    mov     rsi, rbp; filename
    mov     edi, 1; ver
    call    __xstat
    mov     eax, [rsp+6D8h+var_6C0]
    and     eax, 0F000h
    cmp     eax, 8000h
    jz      loc_1B00
    lea     rsi, a134mSM; "\x1B[1;34m%s\x1B[m\t"
    mov     rdx, r15
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
loc_1A89:
    add     ebx, 1
    add     r12d, 1
    cmp     ebx, 5
    jnz     short loc_1A20
    mov     edi, 0Ah; c
    xor     ebx, ebx
    call    putchar
    mov     rdi, r13; dirp
    call    readdir
    test    rax, rax
    jnz     short loc_1A31
    xchg    ax, ax
loc_1AB0:
    mov     eax, r12d
    mov     edx, 66666667h
    imul    edx
    mov     eax, r12d
    sar     eax, 1Fh
    sar     edx, 1
    sub     edx, eax
    lea     eax, [rdx+rdx*4]
    cmp     r12d, eax
    jz      short loc_1AD6
    mov     edi, 0Ah; c
    call    putchar
loc_1AD6:
    mov     rax, [rsp+6D8h+var_40]
    xor     rax, fs:28h
    jnz     loc_1B82
    add     rsp, 6A8h
    pop     rbx
    pop     rbp
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    retn
loc_1B00:
    mov     esi, 1; type
    mov     rdi, r15; name
    call    access
    cmp     eax, 0FFFFFFFFh
    mov     rdx, r15
    jz      short loc_1B30
    lea     rsi, a132mSM; "\x1B[1;32m%s\x1B[m\t"
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
    jmp     loc_1A89
loc_1B30:
    lea     rsi, aS_0; "%s\t"
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
    jmp     loc_1A89
loc_1B50:
    mov     rdi, rbx; name
    call    opendir
    mov     r13, rax
    jmp     loc_1A07
loc_1B60:
    lea     rdi, aGetcwd_0; "getcwd "
    call    puts
    jmp     loc_19E2
loc_1B71:
    lea     rdi, aNoSuchFileOrDi; "No such file or directory!"
    call    puts
    jmp     loc_1AD6
loc_1B82:
    call    __stack_chk_fail
sub_19A0 endp

