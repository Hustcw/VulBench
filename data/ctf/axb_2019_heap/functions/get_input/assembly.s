get_input proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     [rbp+var_10], 0
loc_C34:
    mov     eax, [rbp+var_10]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     [rbp+var_8], rax
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     edx, [rbp+var_10]
    movsxd  rcx, edx
    mov     rdx, [rbp+var_18]
    lea     rdi, [rcx+rdx]; ptr
    mov     rcx, rax; stream
    mov     edx, 1; n
    mov     esi, 1; size
    call    _fread
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 0
    jle     short loc_CA5
    mov     rax, [rbp+var_8]
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_C92
    cmp     [rbp+var_10], 0
    jz      short loc_C34
    mov     rax, [rbp+var_8]
    mov     byte ptr [rax], 0
    jmp     short locret_CA9
loc_C92:
    add     [rbp+var_10], 1
    mov     eax, [rbp+var_1C]
    lea     edx, [rax+1]
    mov     eax, [rbp+var_10]
    cmp     edx, eax
    jbe     short loc_CA8
    jmp     short loc_C34
loc_CA5:
    nop
    jmp     short locret_CA9
loc_CA8:
    nop
locret_CA9:
    leave
    retn
get_input endp

