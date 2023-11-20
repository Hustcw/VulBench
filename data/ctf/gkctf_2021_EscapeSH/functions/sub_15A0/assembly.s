sub_15A0 proc
    push    r14
    push    r13
    push    r12
    push    rbp
    push    rbx
    sub     rsp, 550h
    mov     rax, fs:28h
    mov     [rsp+578h+var_30], rax
    xor     eax, eax
    mov     rax, 7265646E3457h
    mov     rdi, rsp; name
    mov     [rsp+578h+var_3E8], rax
    xor     eax, eax
    mov     [rsp+578h+var_3E0], ax
    call    uname
    test    eax, eax
    jnz     loc_176A
    lea     rbx, [rsp+578h+buf]
    mov     esi, 300h; size
    mov     rdi, rbx; buf
    call    getcwd
    test    rax, rax
    jz      loc_1754
    lea     r13, [rsp+578h+var_3D8]
    mov     ecx, 13h
    xor     eax, eax
    mov     rbp, rsp
    mov     r14, rbx
    mov     rdi, r13
    rep stosq
    mov     byte ptr [rdi], 0
loc_162A:
    mov     edx, [r14]
    add     r14, 4
    lea     eax, [rdx-1010101h]
    not     edx
    and     eax, edx
    and     eax, 80808080h
    jz      short loc_162A
    mov     edx, eax
    lea     r12, path
    mov     rdi, rbx; s1
    shr     edx, 10h
    test    eax, 8080h
    cmovz   eax, edx
    lea     rdx, [r14+2]
    mov     esi, eax
    cmovz   r14, rdx
    add     sil, al
    mov     rsi, r12; s2
    sbb     r14, 3
    sub     r14, rbx
    call    strcmp
    test    eax, eax
    jnz     short loc_16E3
loc_1679:
    mov     esi, 300h; size
    mov     rdi, rbx; buf
    call    getcwd
    mov     rsi, r12; needle
    mov     rdi, rax; haystack
    call    strstr
    test    rax, rax
    jz      loc_172D
    lea     rcx, [rbp+41h]
    lea     rdx, [rsp+578h+var_3E8]
    lea     rsi, a1331mSSM34mSM; "\x1B[1;3;31m%s@%s\x1B[m:\x1B[34m~%s\x1B"...
    mov     r8, r13
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
loc_16BC:
    mov     rax, [rsp+578h+var_30]
    xor     rax, fs:28h
    jnz     loc_1780
    add     rsp, 550h
    pop     rbx
    pop     rbp
    pop     r12
    pop     r13
    pop     r14
    retn
loc_16E3:
    mov     eax, r14d
    movsxd  r14, r14d
    cmp     [rsp+r14+578h+buf], 2Fh ; '/'
    jz      short loc_1708
    nop     dword ptr [rax+00h]
loc_16F8:
    sub     eax, 1
    movsxd  rdx, eax
    cmp     [rsp+rdx+578h+buf], 2Fh ; '/'
    jnz     short loc_16F8
loc_1708:
    mov     rcx, r13
    mov     edx, 2Fh ; '/'
loc_1710:
    add     eax, 1
    mov     [rcx], dl
    add     rcx, 1
    movsxd  rdx, eax
    movzx   edx, [rsp+rdx+578h+buf]
    test    dl, dl
    jnz     short loc_1710
    jmp     loc_1679
loc_172D:
    lea     rcx, [rbp+41h]
    lea     rdx, [rsp+578h+var_3E8]
    lea     rsi, a1331mSSM34mSM_0; "\x1B[1;3;31m%s@%s\x1B[m:\x1B[34m%s\x1B["...
    mov     r8, rbx
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
    jmp     loc_16BC
loc_1754:
    lea     rdi, aGetPathNameErr; "get path_name error"
    call    puts
    mov     edi, 0FFFFFFFFh; status
    call    exit
loc_176A:
    lea     rdi, aUname_0; "uname"
    call    perror
    mov     edi, 1; status
    call    exit
loc_1780:
    call    __stack_chk_fail
sub_15A0 endp

