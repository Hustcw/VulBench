sub_400957 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+fd], edi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_28], rdx
    mov     [rbp+var_10], 0
    jmp     short loc_4009D4
loc_400974:
    mov     rax, [rbp+var_28]
    sub     rax, [rbp+var_10]
    mov     rdx, rax; nbytes
    mov     rcx, [rbp+var_20]
    mov     rax, [rbp+var_10]
    add     rcx, rax
    mov     eax, [rbp+fd]
    mov     rsi, rcx; buf
    mov     edi, eax; fd
    call    read
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 0FFFFFFFFFFFFFFFFh
    jnz     short loc_4009C5
    call    __errno_location
    mov     eax, [rax]
    cmp     eax, 0Bh
    jz      short loc_4009D4
    call    __errno_location
    mov     eax, [rax]
    cmp     eax, 4
    jnz     short loc_4009BC
    jmp     short loc_4009D4
loc_4009BC:
    mov     rax, 0FFFFFFFFFFFFFFFFh
    jmp     short locret_4009E5
loc_4009C5:
    cmp     [rbp+var_8], 0
    jz      short loc_4009E0
    mov     rax, [rbp+var_8]
    add     [rbp+var_10], rax
loc_4009D4:
    mov     rax, [rbp+var_10]
    cmp     rax, [rbp+var_28]
    jb      short loc_400974
    jmp     short loc_4009E1
loc_4009E0:
    nop
loc_4009E1:
    mov     rax, [rbp+var_10]
locret_4009E5:
    leave
    retn
sub_400957 endp

