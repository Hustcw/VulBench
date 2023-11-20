sub_AB0 proc
    push    rbp
    push    rbx
    mov     eax, 1
    lea     rdx, byte_202038
    sub     rsp, 8
    cmp     cs:qword_202040, 0
    jz      loc_B60
loc_AD0:
    movsxd  rbx, eax
    add     rax, 1
    cmp     qword ptr [rdx+rax*8], 0
    jnz     short loc_AD0
loc_ADE:
    mov     edi, 70h ; 'p'; size
    lea     rbp, qword_202040
    call    _malloc
    lea     rdi, aTitle; "title:"
    mov     [rbp+rbx*8+0], rax
    call    _puts
    mov     rsi, [rbp+rbx*8+0]; buf
    mov     edx, 8; nbytes
    xor     edi, edi; fd
    xor     eax, eax
    call    _read
    lea     rdi, aContent; "content:"
    call    _puts
    mov     rax, [rbp+rbx*8+0]
    mov     edx, 68h ; 'h'; nbytes
    xor     edi, edi; fd
    lea     rsi, [rax+8]; buf
    xor     eax, eax
    call    _read
    mov     rdx, [rbp+rbx*8+0]
    add     rsp, 8
    lea     rsi, aSS; "%s %s"
    pop     rbx
    pop     rbp
    lea     rcx, [rdx+8]
    mov     edi, 1
    xor     eax, eax
    jmp     ___printf_chk
loc_B60:
    xor     ebx, ebx
    jmp     loc_ADE
sub_AB0 endp

