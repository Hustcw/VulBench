sub_F29 proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 128h
    lea     rdx, [rbp+buf]
    mov     eax, 0
    mov     ecx, 20h ; ' '
    mov     rdi, rdx
    rep stosq
    mov     [rbp+var_18], 0
    mov     [rbp+size], 0
    mov     [rbp+var_20], 0
    lea     rdi, format; "Name: "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fileno
    mov     ecx, eax
    lea     rax, [rbp+buf]
    mov     edx, 100h; nbytes
    mov     rsi, rax; buf
    mov     edi, ecx; fd
    call    read
    mov     [rbp+var_18], rax
    cmp     [rbp+var_18], 0
    jg      short loc_FB7
    mov     eax, 0
    call    sub_A70
loc_FB7:
    mov     [rbp+var_21], 0
    lea     rdi, aSize; "Size: "
    mov     eax, 0
    call    printf
    lea     rax, [rbp+size]
    mov     rsi, rax
    lea     rdi, aLu; "%lu"
    mov     eax, 0
    call    __isoc99_scanf
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fgetc
    mov     rax, [rbp+size]
    cmp     rax, 400h
    jbe     short loc_1012
    mov     eax, 0
    call    sub_A70
loc_1012:
    mov     rax, [rbp+size]
    mov     rdi, rax; size
    call    malloc
    mov     [rbp+var_20], rax
    cmp     [rbp+var_20], 0
    jnz     short loc_1036
    mov     eax, 0
    call    sub_A70
loc_1036:
    lea     rdi, aValue; "Value: "
    mov     eax, 0
    call    printf
    mov     rbx, [rbp+size]
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fileno
    mov     ecx, eax
    mov     rax, [rbp+var_20]
    mov     rdx, rbx; nbytes
    mov     rsi, rax; buf
    mov     edi, ecx; fd
    call    read
    mov     [rbp+var_18], rax
    cmp     [rbp+var_18], 0
    jg      short loc_1088
    mov     eax, 0
    call    sub_A70
loc_1088:
    mov     rax, [rbp+size]
    shl     rax, 30h
    mov     rdx, rax
    mov     rax, [rbp+var_20]
    or      rax, rdx
    mov     [rbp+var_20], rax
    lea     rax, [rbp+buf]
    mov     rdi, rax; s
    call    strdup
    mov     rdx, rax
    mov     rax, [rbp+var_20]
    mov     rsi, rax
    mov     rdi, rdx
    call    sub_CB6
    nop
    add     rsp, 128h
    pop     rbx
    pop     rbp
    retn
sub_F29 endp

