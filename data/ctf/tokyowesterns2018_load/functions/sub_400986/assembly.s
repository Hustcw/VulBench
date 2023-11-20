sub_400986 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+s], rdi
    mov     [rbp+n], esi
    cmp     [rbp+n], 0
    js      short loc_4009D8
    mov     rdx, cs:stdin; stream
    mov     ecx, [rbp+n]
    mov     rax, [rbp+s]
    mov     esi, ecx; n
    mov     rdi, rax; s
    call    fgets
    mov     rax, [rbp+s]
    mov     esi, 0Ah; c
    mov     rdi, rax; s
    call    strchr
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0
    jz      short locret_4009D9
    mov     rax, [rbp+var_8]
    mov     byte ptr [rax], 0
    jmp     short locret_4009D9
loc_4009D8:
    nop
locret_4009D9:
    leave
    retn
sub_400986 endp

