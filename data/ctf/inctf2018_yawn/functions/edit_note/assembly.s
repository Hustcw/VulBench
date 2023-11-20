edit_note proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 180h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+idx], 0
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
    lea     rdi, aEnterIndex; "Enter index: "
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    get_int
    mov     [rbp+idx], eax
    cmp     [rbp+idx], 0
    js      short loc_400D26
    cmp     [rbp+idx], 9
    jg      short loc_400D26
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jnz     short loc_400D30
loc_400D26:
    mov     eax, 0
    jmp     loc_400E3A
loc_400D30:
    lea     rdi, aEnterName; "Enter name: "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdin_ptr
    mov     rdx, [rax]; stream
    lea     rax, [rbp+name]
    mov     esi, 51h ; 'Q'; n
    mov     rdi, rax; s
    call    fgets
    lea     rdi, aEnterSize; "Enter size: "
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    get_ll
    mov     [rbp+size], rax
    lea     rdi, aEnterDesc; "Enter desc: "
    mov     eax, 0
    call    printf
    cmp     [rbp+size], 100h
    jg      short loc_400DD5
    mov     rax, cs:stdin_ptr
    mov     rdx, [rax]; stream
    lea     rax, [rbp+desc]
    mov     esi, 101h; n
    mov     rdi, rax; s
    call    fgets
    lea     rax, [rbp+desc]
    mov     rdi, rax; s
    call    strdup
    mov     [rbp+ptr], rax
    jmp     short loc_400E12
loc_400DD5:
    mov     rax, [rbp+size]
    mov     rdi, rax; size
    call    malloc
    mov     [rbp+ptr], rax
    mov     rax, cs:stdin_ptr
    mov     rdx, [rax]; stream
    mov     rax, [rbp+size]
    add     eax, 1
    mov     ecx, eax
    mov     rax, [rbp+ptr]
    mov     esi, ecx; n
    mov     rdi, rax; s
    call    fgets
loc_400E12:
    mov     ecx, [rbp+idx]; idx
    mov     rdx, [rbp+ptr]; desc
    mov     rsi, [rbp+size]; size
    lea     rax, [rbp+name]
    mov     rdi, rax; name
    call    insert
    mov     eax, 0
loc_400E3A:
    mov     rsi, [rbp+var_8]
    xor     rsi, fs:28h
    jz      short locret_400E4E
    call    __stack_chk_fail
locret_400E4E:
    leave
    retn
edit_note endp

