sub_B20 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    jmp     short loc_BA7
loc_B47:
    mov     [rbp+buf], 0
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    test    rax, rax
    jns     short loc_B7C
    lea     rdi, s; "Read error."
    call    _puts
    mov     edi, 0FFFFFFFEh; status
    call    _exit
loc_B7C:
    movzx   eax, [rbp+buf]
    cmp     al, 0Ah
    jnz     short loc_B93
    mov     edx, [rbp+var_C]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_BBC
loc_B93:
    mov     edx, [rbp+var_C]
    mov     rax, [rbp+var_18]
    add     rdx, rax
    movzx   eax, [rbp+buf]
    mov     [rdx], al
    add     [rbp+var_C], 1
loc_BA7:
    mov     eax, [rbp+var_C]
    cmp     eax, [rbp+var_1C]
    jb      short loc_B47
    mov     edx, [rbp+var_C]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
loc_BBC:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_BD0
    call    ___stack_chk_fail
locret_BD0:
    leave
    retn
sub_B20 endp

