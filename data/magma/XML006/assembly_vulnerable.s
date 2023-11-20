xmlSnprintfElementContent proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    test    content, content
    jz      loc_438E46
    mov     r15d, ecx
    mov     r12, content
    mov     ebx, esi
    mov     r14, buf
    call    _strlen
    mov     ebp, ebx
    sub     ebp, eax
    cmp     ebp, 31h ; '1'
    jg      short loc_438C6E
    cmp     ebp, 5
    jl      loc_438E46
loc_438C33:
    shl     len, 20h
    mov     rcx, 0FFFFFFFF00000000h
    add     rcx, rax
    sar     rcx, 20h
    cmp     byte ptr [buf+rcx], 2Eh ; '.'
    jz      loc_438E46
loc_438C53:
    mov     rdi, buf; s
    call    _strlen
    mov     dword ptr [buf+rax], 2E2E2E20h
    mov     byte ptr [buf+rax+4], 0
    jmp     loc_438E46
loc_438C6E:
    test    r15d, r15d
    jz      short loc_438C82
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 28h ; '('
loc_438C82:
    mov     eax, [content]
    add     eax, 0FFFFFFFFh; switch 4 cases
    cmp     eax, 3
    ja      def_438C92; jumptable 0000000000438C92 default case
def_438C92:
    jmp     ds:jpt_438C92[rax*8]; switch jump
    mov     rdi, buf; jumptable 0000000000438C92 case 1
    call    _strlen
    mov     rcx, 41544144435023h
    mov     [buf+rax], rcx
    test    r15d, r15d
    jnz     loc_438DF2
    jmp     loc_438E01
    mov     rdi, [content+28h]; jumptable 0000000000438C92 case 2
    test    rdi, rdi
    jz      short loc_438CEF
    call    xmlStrlen
    add     eax, 0Ah
    cmp     ebp, eax
    jl      short loc_438C53
    mov     rsi, [content+28h]; src
    mov     rdi, buf; dest
    call    _strcat
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 3Ah ; ':'
loc_438CEF:
    mov     rdi, [content+8]; str
    call    xmlStrlen
    add     eax, 0Ah
    cmp     ebp, eax
    jl      loc_438C53
    mov     rsi, [content+8]; src
    test    rsi, rsi
    jz      def_438C92; jumptable 0000000000438C92 default case
    mov     rdi, buf; dest
    call    _strcat
    test    r15d, r15d
    jnz     loc_438DF2
    jmp     loc_438E01
    mov     rdx, [content+10h]; jumptable 0000000000438C92 case 3
    mov     eax, [rdx]
    add     eax, 0FFFFFFFDh
    xor     ecx, ecx
    cmp     eax, 2
    setb    cl; englob
    mov     rdi, buf; buf
    mov     esi, ebx; size
    call    xmlSnprintfElementContent
    mov     rdi, buf; s
    call    _strlen
    mov     ecx, ebx
    sub     ecx, eax
    cmp     ecx, 31h ; '1'
    jle     short loc_438DA0
    mov     rdi, buf; s
    call    _strlen
    mov     dword ptr [buf+rax], 202C20h
    mov     rdx, [content+18h]
    mov     eax, [rdx]
    cmp     eax, 4
    jnz     short loc_438DCA
    jmp     short loc_438DD5
    mov     rdx, [content+10h]; jumptable 0000000000438C92 case 4
    mov     eax, [rdx]
    add     eax, 0FFFFFFFDh
    xor     ecx, ecx
    cmp     eax, 2
    setb    cl; englob
    mov     rdi, buf; buf
    mov     esi, ebx; size
    call    xmlSnprintfElementContent
    mov     rdi, buf; s
    call    _strlen
    mov     ecx, ebx
    sub     ecx, eax
    cmp     ecx, 31h ; '1'
    jg      short loc_438DAE
loc_438DA0:
    cmp     ecx, 5
    jge     loc_438C33
    jmp     loc_438E46
loc_438DAE:
    mov     rdi, buf; s
    call    _strlen
    mov     dword ptr [buf+rax], 207C20h
    mov     rdx, [content+18h]; content
    mov     eax, [rdx]
    cmp     eax, 3
    jz      short loc_438DD5
loc_438DCA:
    cmp     eax, 2
    jz      short loc_438DE1
    cmp     dword ptr [rdx+4], 1
    jz      short loc_438DE1
loc_438DD5:
    mov     rdi, buf
    mov     esi, ebx
    mov     ecx, 1
    jmp     short loc_438DE8
loc_438DE1:
    mov     rdi, buf; buf
    mov     esi, ebx; size
    xor     ecx, ecx; englob
loc_438DE8:
    call    xmlSnprintfElementContent
    test    r15d, r15d; jumptable 0000000000438C92 default case
    jz      short loc_438E01
loc_438DF2:
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 29h ; ')'
loc_438E01:
    mov     eax, [content+4]
    cmp     eax, 4
    jz      short loc_438E26
    cmp     eax, 3
    jz      short loc_438E37
    cmp     eax, 2
    jnz     short loc_438E46
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 3Fh ; '?'
    jmp     short loc_438E46
loc_438E26:
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 2Bh ; '+'
    jmp     short loc_438E46
loc_438E37:
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 2Ah ; '*'
loc_438E46:
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    pop     rbp
    retn
xmlSnprintfElementContent endp

