add_note proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 180h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+i], 0
    lea     rdx, [rbp+desc]
    mov     eax, 0
    mov     ecx, 20h ; ' '
    mov     rdi, rdx
    rep stosq
    lea     rdx, [rbp+name]
    mov     eax, 0
    mov     ecx, 0Ah
    mov     rdi, rdx
    rep stosq
    mov     [rbp+i], 0
    jmp     short loc_400B66
loc_400B46:
    lea     rax, table
    mov     edx, [rbp+i]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jz      short loc_400B71
    add     [rbp+i], 1
loc_400B66:
    cmp     [rbp+i], 9
    jle     short loc_400B46
    jmp     short loc_400B72
loc_400B71:
    nop
loc_400B72:
    cmp     [rbp+i], 0Ah
    jnz     short loc_400B85
    mov     eax, 0
    jmp     loc_400C72
loc_400B85:
    mov     eax, [rbp+i]
    mov     esi, eax
    lea     rdi, format; "ID : %d\n"
    mov     eax, 0
    call    printf
    lea     rdi, aEnterName; "Enter name: "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdin_ptr
    mov     rdx, [rax]; stream
    lea     rax, [rbp+name]
    mov     esi, 51h ; 'Q'; n
    mov     rdi, rax; s
    call    fgets
    lea     rdi, aEnterDesc; "Enter desc: "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdin_ptr
    mov     rdx, [rax]; stream
    lea     rax, [rbp+desc]
    mov     esi, 101h; n
    mov     rdi, rax; s
    call    fgets
    lea     rax, [rbp+desc]
    mov     rdi, rax; s
    call    strlen
    mov     [rbp+size], rax
    lea     rax, [rbp+desc]
    mov     rdi, rax; s
    call    strdup
    mov     [rbp+ptr], rax
    mov     edi, 60h ; '`'; size
    call    malloc
    mov     rcx, rax
    lea     rax, table
    mov     edx, [rbp+i]
    movsxd  rdx, edx
    mov     [rax+rdx*8], rcx
    mov     ecx, [rbp+i]; idx
    mov     rdx, [rbp+ptr]; desc
    mov     rsi, [rbp+size]; size
    lea     rax, [rbp+name]
    mov     rdi, rax; name
    call    insert
    mov     eax, [rbp+i]
loc_400C72:
    mov     rsi, [rbp+var_8]
    xor     rsi, fs:28h
    jz      short locret_400C86
    call    __stack_chk_fail
locret_400C86:
    leave
    retn
add_note endp

