sub_40151A proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 38h
    mov     [rbp+var_38], rdi
    mov     [rbp+s], rsi
    cmp     [rbp+var_38], 0
    jz      loc_401615
    mov     rax, [rbp+var_38]
    mov     eax, [rax+8]
    cdqe
    shl     rax, 3
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+ptr], rax
    mov     [rbp+var_28], 0
    mov     rdx, cs:delim
    mov     rax, [rbp+s]
    mov     rsi, rdx; delim
    mov     rdi, rax; s
    call    _strtok
    mov     [rbp+nptr], rax
    jmp     short loc_4015B2
loc_401572:
    mov     eax, [rbp+var_28]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    lea     rbx, [rdx+rax]
    mov     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atol
    mov     [rbx], rax
    add     [rbp+var_28], 1
    mov     rax, cs:delim
    mov     rsi, rax; delim
    mov     edi, 0; s
    call    _strtok
    mov     [rbp+nptr], rax
loc_4015B2:
    mov     rax, [rbp+var_38]
    mov     eax, [rax+8]
    cmp     [rbp+var_28], eax
    jge     short loc_4015C5
    cmp     [rbp+nptr], 0
    jnz     short loc_401572
loc_4015C5:
    mov     eax, [rbp+var_28]
    sub     eax, 1
    mov     [rbp+var_24], eax
    jmp     short loc_4015FE
loc_4015D0:
    mov     eax, [rbp+var_24]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     rdx, [rax]
    mov     rax, [rbp+var_38]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40144E
    test    eax, eax
    jz      short loc_401606
    sub     [rbp+var_24], 1
loc_4015FE:
    cmp     [rbp+var_24], 0
    jns     short loc_4015D0
    jmp     short loc_401607
loc_401606:
    nop
loc_401607:
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    jmp     short loc_401616
loc_401615:
    nop
loc_401616:
    add     rsp, 38h
    pop     rbx
    pop     rbp
    retn
sub_40151A endp

