add_item proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, cs:num
    cmp     eax, 63h ; 'c'
    jg      loc_400AFE
    mov     edi, offset aPleaseEnterThe; "Please enter the length of servant name"...
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_18], eax
    cmp     [rbp+var_18], 0
    jnz     short loc_400A2B
    mov     edi, offset aInvaildLength; "invaild length"
    call    _puts
    mov     eax, 0
    jmp     loc_400B0D
loc_400A2B:
    mov     [rbp+var_1C], 0
    jmp     loc_400AF2
loc_400A37:
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rax, [rax]
    test    rax, rax
    jnz     loc_400AEE
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    lea     rdx, itemlist[rax]
    mov     eax, [rbp+var_18]
    mov     [rdx], eax
    mov     eax, [rbp+var_18]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rdx, rax
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     [rax], rdx
    mov     edi, offset aPleaseEnterThe_0; "Please enter the name of servant:"
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax; nbytes
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rax, [rax]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_14], eax
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    add     rax, 6020C8h
    mov     rdx, [rax]
    mov     eax, [rbp+var_14]
    cdqe
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     eax, cs:num
    add     eax, 1
    mov     cs:num, eax
    jmp     short loc_400B08
loc_400AEE:
    add     [rbp+var_1C], 1
loc_400AF2:
    cmp     [rbp+var_1C], 63h ; 'c'
    jle     loc_400A37
    jmp     short loc_400B08
loc_400AFE:
    mov     edi, offset aTheTeamIsFull; "the team is full"
    call    _puts
loc_400B08:
    mov     eax, 0
loc_400B0D:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400B21
    call    ___stack_chk_fail
locret_400B21:
    leave
    retn
add_item endp

