sub_400B76 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_8], 0
loc_400B8E:
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_8]
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    cmp     rax, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_400BBB
    mov     edi, 1; status
    call    _exit
loc_400BBB:
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_8]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_400BDD
    mov     rdx, [rbp+var_18]
    mov     rax, [rbp+var_8]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short locret_400BFE
loc_400BDD:
    add     [rbp+var_8], 1
    mov     rax, [rbp+var_8]
    cmp     rax, [rbp+var_20]
    jb      short loc_400B8E
    mov     rax, [rbp+var_8]
    lea     rdx, [rax-1]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
locret_400BFE:
    leave
    retn
sub_400B76 endp

