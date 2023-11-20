xmlSnprintfElementContent proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    test    content, content
    jz      loc_438FA3
    mov     r15d, ecx
    mov     rbx, content
    mov     r13d, esi
    mov     r14, buf
    call    _strlen
    mov     ebp, r13d
    sub     ebp, eax
    cmp     ebp, 31h ; '1'
    jg      short loc_438DA9
    cmp     ebp, 5
    jl      loc_438FA3
loc_438D88:
    shl     len, 20h
    mov     rcx, 0FFFFFFFF00000000h
    add     rcx, rax
    sar     rcx, 20h
    cmp     byte ptr [buf+rcx], 2Eh ; '.'
    jnz     short loc_438E1C
    jmp     loc_438FA3
loc_438DA9:
    test    r15d, r15d
    jz      short loc_438DBD
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 28h ; '('
loc_438DBD:
    mov     eax, [content]
    add     eax, 0FFFFFFFFh; switch 4 cases
    cmp     eax, 3
    ja      def_438DCB; jumptable 0000000000438DCB default case
def_438DCB:
    jmp     ds:jpt_438DCB[rax*8]; switch jump
    mov     rdi, buf; jumptable 0000000000438DCB case 1
    call    _strlen
    mov     rcx, 41544144435023h
    mov     [buf+rax], rcx
    jmp     def_438DCB; jumptable 0000000000438DCB default case
    mov     rdi, [content+8]; jumptable 0000000000438DCB case 2
    call    xmlStrlen
    mov     r12d, eax
    mov     rdi, [content+28h]; str
    test    rdi, rdi
    jz      short loc_438E0F
    call    xmlStrlen
    lea     r12d, [qnameLen+rax]
    add     r12d, 1
loc_438E0F:
    add     r12d, 0Ah
    cmp     ebp, r12d
    jge     loc_438EC5
loc_438E1C:
    mov     rdi, buf; s
    call    _strlen
    mov     dword ptr [buf+rax], 2E2E2E20h
    mov     byte ptr [buf+rax+4], 0
    jmp     loc_438FA3
    mov     rdx, [content+10h]; jumptable 0000000000438DCB case 3
    mov     eax, [rdx]
    add     eax, 0FFFFFFFDh
    xor     ecx, ecx
    cmp     eax, 2
    setb    cl; englob
    mov     rdi, buf; buf
    mov     esi, r13d; size
    call    xmlSnprintfElementContent
    mov     rdi, buf; s
    call    _strlen
    mov     ecx, r13d
    sub     ecx, eax
    cmp     ecx, 31h ; '1'
    jle     short loc_438EB7
    mov     rdi, buf; s
    call    _strlen
    mov     dword ptr [buf+rax], 202C20h
    mov     rdx, [content+18h]
    mov     eax, [rdx]
    cmp     eax, 4
    jnz     loc_438F13
    jmp     loc_438F1E
    mov     rdx, [content+10h]; jumptable 0000000000438DCB case 4
    mov     eax, [rdx]
    add     eax, 0FFFFFFFDh
    xor     ecx, ecx
    cmp     eax, 2
    setb    cl; englob
    mov     rdi, buf; buf
    mov     esi, r13d; size
    call    xmlSnprintfElementContent
    mov     rdi, buf; s
    call    _strlen
    mov     ecx, r13d
    sub     ecx, eax
    cmp     ecx, 31h ; '1'
    jg      short loc_438EF8
loc_438EB7:
    cmp     ecx, 5
    jge     loc_438D88
    jmp     loc_438FA3
loc_438EC5:
    mov     rsi, [content+28h]; src
    test    rsi, rsi
    jz      short loc_438EE5
    mov     rdi, buf; dest
    call    _strcat
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 3Ah ; ':'
loc_438EE5:
    mov     rsi, [content+8]; src
    test    rsi, rsi
    jz      short def_438DCB; jumptable 0000000000438DCB default case
    mov     rdi, buf; dest
    call    _strcat
    jmp     short def_438DCB; jumptable 0000000000438DCB default case
loc_438EF8:
    mov     rdi, buf; s
    call    _strlen
    mov     dword ptr [buf+rax], 207C20h
    mov     rdx, [content+18h]; content
    mov     eax, [rdx]
    cmp     eax, 3
    jz      short loc_438F1E
loc_438F13:
    cmp     eax, 2
    jz      short loc_438F2B
    cmp     dword ptr [rdx+4], 1
    jz      short loc_438F2B
loc_438F1E:
    mov     rdi, buf
    mov     esi, r13d
    mov     ecx, 1
    jmp     short loc_438F33
loc_438F2B:
    mov     rdi, buf; buf
    mov     esi, r13d; size
    xor     ecx, ecx; englob
loc_438F33:
    call    xmlSnprintfElementContent
    movsxd  rbp, r13d; jumptable 0000000000438DCB default case
    mov     rdi, buf; s
    call    _strlen
    sub     rbp, rax
    cmp     rbp, 3
    jb      short loc_438FA3
    test    r15d, r15d
    jz      short loc_438F60
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 29h ; ')'
loc_438F60:
    mov     eax, [content+4]
    cmp     eax, 4
    jz      short loc_438F83
    cmp     eax, 3
    jz      short loc_438F94
    cmp     eax, 2
    jnz     short loc_438FA3
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 3Fh ; '?'
    jmp     short loc_438FA3
loc_438F83:
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 2Bh ; '+'
    jmp     short loc_438FA3
loc_438F94:
    mov     rdi, buf; s
    call    _strlen
    mov     word ptr [buf+rax], 2Ah ; '*'
loc_438FA3:
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
xmlSnprintfElementContent endp

