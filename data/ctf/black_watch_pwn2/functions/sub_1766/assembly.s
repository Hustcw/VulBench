sub_1766 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     rax, cs:qword_4010
    test    rax, rax
    jg      short loc_178A
    mov     eax, 0
    call    sub_1521
    jmp     short loc_179C
loc_178A:
    mov     rax, cs:qword_4010
    sub     rax, 1
    mov     cs:qword_4010, rax
loc_179C:
    lea     rdi, aPleaseInputThe; "Please input the red packet idx: "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_14F5
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 10h
    ja      short loc_17D9
    mov     eax, [rbp+var_4]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_17E3
loc_17D9:
    mov     eax, 0
    call    sub_1521
loc_17E3:
    lea     rdi, aPleaseInputCon; "Please input content: "
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_4]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     eax, [rax+8]
    movsxd  rdx, eax; nbytes
    mov     eax, [rbp+var_4]
    shl     rax, 4
    mov     rcx, rax
    mov     rax, [rbp+var_18]
    add     rax, rcx
    mov     rax, [rax]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_8], eax
    cmp     [rbp+var_8], 0
    jle     short loc_185B
    mov     eax, [rbp+var_4]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     rax, [rax]
    mov     edx, [rbp+var_8]
    movsxd  rdx, edx
    sub     rdx, 1
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_1865
loc_185B:
    mov     eax, 0
    call    sub_1521
loc_1865:
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
    leave
    retn
sub_1766 endp

