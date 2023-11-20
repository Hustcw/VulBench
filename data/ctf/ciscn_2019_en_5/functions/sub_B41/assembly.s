sub_B41 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, [rbp+var_18]
    mov     [rbp+buf], rax
loc_B67:
    mov     eax, [rbp+var_1C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    cmp     rax, [rbp+buf]
    jz      short loc_BB3
    mov     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    cmp     rax, 1
    jnz     short loc_BB6
    mov     rax, [rbp+buf]
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jz      short loc_BB7
    mov     rax, [rbp+buf]
    movzx   eax, byte ptr [rax]
    test    al, al
    jz      short loc_BB7
    add     [rbp+buf], 1
    jmp     short loc_B67
loc_BB3:
    nop
    jmp     short loc_BB7
loc_BB6:
    nop
loc_BB7:
    mov     rax, [rbp+buf]
    mov     byte ptr [rax], 0
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_BD3
    call    __stack_chk_fail
locret_BD3:
    leave
    retn
sub_B41 endp

