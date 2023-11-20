xmlStrncatNew proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     ebx, edx
    mov     r15, str2
    mov     r14, str1
    test    edx, edx
    js      short loc_46D7DC
    test    str2, str2
    jz      short loc_46D7EB
loc_46D76C:
    test    ebx, ebx
    jz      short loc_46D7EB
    test    str1, str1
    jz      loc_46D801
    mov     rdi, str1; str
    call    xmlStrlen
    mov     r12d, eax
    lea     eax, [size+len]
    add     eax, 1
    movsxd  rdi, eax; size
    call    cs:xmlMalloc
    test    rax, rax
    jz      short loc_46D808
    mov     r13, rax
    movsxd  rbp, r12d
    add     r12d, ebx
    mov     rdi, rax; dest
    mov     rsi, str1; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rdi, ret
    add     rdi, rbp; dest
    movsxd  rdx, ebx; n
    mov     rsi, str2; src
    call    _memcpy
    movsxd  rax, r12d
    mov     byte ptr [ret+rax+0], 0
    mov     rax, ret
    add     rsp, 8
    pop     len
    pop     r12
    pop     ret
    pop     str1
    pop     str2
    pop     rbp
    retn
loc_46D7DC:
    mov     rdi, str2; str
    call    xmlStrlen
    mov     ebx, eax
    test    str2, str2
    jnz     short loc_46D76C
loc_46D7EB:
    mov     rdi, str1
    add     rsp, 8
    pop     len
    pop     r12
    pop     r13
    pop     str1
    pop     str2
    pop     rbp
    jmp     xmlStrdup
loc_46D801:
    mov     rdi, str2
    mov     esi, ebx
    jmp     short loc_46D817
loc_46D808:
    xor     edi, edi; ctxt
    xor     esi, esi; extra
    call    xmlErrMemory
    mov     rdi, str1
    mov     esi, r12d
loc_46D817:
    add     rsp, 8
    pop     len
    pop     r12
    pop     r13
    pop     str1
    pop     str2
    pop     rbp
    jmp     xmlStrndup
xmlStrncatNew endp



xmlStrlen proc
    xor     eax, eax
    test    str, str
    jz      short locret_46D5DB
    cmp     byte ptr [str], 0
    jz      short locret_46D5DB
    xor     eax, eax
    xchg    ax, ax
loc_46D5D0:
    cmp     byte ptr [rdi+rax+1], 0
    lea     rax, [rax+1]
    jnz     short loc_46D5D0
locret_46D5DB:
    retn
xmlStrlen endp



xmlStrncat proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    mov     r15, cur
    test    add, add
    jz      short loc_46D73C
    mov     ebx, edx
    test    edx, edx
    jz      short loc_46D73C
    test    ebx, ebx
    js      short loc_46D71B
    mov     r14, add
    test    cur, cur
    jz      short loc_46D720
    mov     rdi, cur; str
    call    xmlStrlen
    mov     r12d, eax
    lea     eax, [size+len]
    add     eax, 1
    movsxd  rsi, eax; size
    mov     rdi, cur; ptr
    call    cs:xmlRealloc
    test    rax, rax
    jz      short loc_46D733
    mov     r13, rax
    movsxd  rdi, r12d
    add     r12d, ebx
    add     rdi, rax; dest
    movsxd  rdx, ebx; n
    mov     rsi, add; src
    call    _memcpy
    movsxd  rax, r12d
    mov     byte ptr [ret+rax+0], 0
    mov     cur, ret
    jmp     short loc_46D73C
loc_46D71B:
    xor     r15d, r15d
    jmp     short loc_46D73C
loc_46D720:
    mov     rdi, add
    mov     esi, ebx
    pop     len
    pop     r12
    pop     r13
    pop     add
    pop     cur
    jmp     xmlStrndup
loc_46D733:
    xor     edi, edi; ctxt
    xor     esi, esi; extra
    call    xmlErrMemory
loc_46D73C:
    mov     rax, r15
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    retn
xmlStrncat endp

