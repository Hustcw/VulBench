sub_1790 proc
    push    r12
    push    rbp
    mov     esi, 300h; n
    push    rbx
    sub     rsp, 310h
    mov     rax, fs:28h
    mov     [rsp+328h+var_20], rax
    xor     eax, eax
    mov     rax, cs:stdin_ptr
    mov     rdi, rsp; s
    mov     rbx, rsp
    mov     rdx, [rax]; stream
    call    fgets
    mov     rdx, rsp
loc_17CB:
    mov     ecx, [rdx]
    add     rdx, 4
    lea     eax, [rcx-1010101h]
    not     ecx
    and     eax, ecx
    and     eax, 80808080h
    jz      short loc_17CB
    mov     ecx, eax
    shr     ecx, 10h
    test    eax, 8080h
    cmovz   eax, ecx
    lea     rcx, [rdx+2]
    cmovz   rdx, rcx
    mov     ecx, eax
    add     cl, al
    sbb     rdx, 3
    sub     rdx, rbx
    sub     rdx, 1
    cmp     [rsp+rdx+328h+var_328], 0Ah
    jz      loc_189E
loc_1810:
    lea     rsi, aS+2; delim
    mov     rdi, rbx; s
    call    strtok
    test    rax, rax
    mov     rbx, rax
    jz      loc_18A7
    lea     rbp, unk_204040
    xor     r12d, r12d
    nop     dword ptr [rax]
loc_1838:
    mov     rdi, rbx; s
    add     r12d, 1
    add     rbp, 8
    call    strlen
    mov     rdi, rax; size
    call    malloc
    mov     rsi, rbx; src
    mov     [rbp-8], rax
    mov     rdi, rax; dest
    call    strcpy
    lea     rsi, aS+2; delim
    xor     edi, edi; s
    call    strtok
    test    rax, rax
    mov     rbx, rax
    jnz     short loc_1838
loc_1875:
    lea     rax, unk_205B40
    mov     [rax], r12d
    mov     rax, [rsp+328h+var_20]
    xor     rax, fs:28h
    jnz     short loc_18AC
    add     rsp, 310h
    pop     rbx
    pop     rbp
    pop     r12
    retn
loc_189E:
    mov     [rsp+rdx+328h+var_328], 0
    jmp     loc_1810
loc_18A7:
    xor     r12d, r12d
    jmp     short loc_1875
loc_18AC:
    call    __stack_chk_fail
sub_1790 endp

