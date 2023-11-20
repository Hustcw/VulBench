sub_153B proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 28h
    mov     [rbp+var_28], rdi
    lea     rdi, aPleaseInputThe; "Please input the red packet idx: "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_14F5
    mov     [rbp+var_18], eax
    cmp     [rbp+var_18], 10h
    jbe     short loc_1576
    mov     eax, 0
    call    sub_1521
loc_1576:
    lea     rdi, aHowMuchDoYouWa; "How much do you want?(1.0x10 2.0xf0 3.0"...
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_14F5
    mov     [rbp+var_1C], eax
    mov     [rbp+var_14], 0
    cmp     [rbp+var_1C], 2
    jz      short loc_15C6
    cmp     [rbp+var_1C], 2
    jg      short loc_15AF
    cmp     [rbp+var_1C], 1
    jz      short loc_15BD
    jmp     short loc_15E1
loc_15AF:
    cmp     [rbp+var_1C], 3
    jz      short loc_15CF
    cmp     [rbp+var_1C], 4
    jz      short loc_15D8
    jmp     short loc_15E1
loc_15BD:
    mov     [rbp+var_14], 10h
    jmp     short loc_15E9
loc_15C6:
    mov     [rbp+var_14], 0F0h
    jmp     short loc_15E9
loc_15CF:
    mov     [rbp+var_14], 300h
    jmp     short loc_15E9
loc_15D8:
    mov     [rbp+var_14], 400h
    jmp     short loc_15E9
loc_15E1:
    mov     [rbp+var_14], 0
    nop
loc_15E9:
    cmp     [rbp+var_14], 10h
    jz      short loc_1614
    cmp     [rbp+var_14], 0F0h
    jz      short loc_1614
    cmp     [rbp+var_14], 300h
    jz      short loc_1614
    cmp     [rbp+var_14], 400h
    jz      short loc_1614
    mov     eax, 0
    call    sub_1521
loc_1614:
    mov     eax, [rbp+var_14]
    cdqe
    mov     edx, [rbp+var_18]
    mov     rcx, rdx
    shl     rcx, 4
    mov     rdx, [rbp+var_28]
    lea     rbx, [rcx+rdx]
    mov     rsi, rax; size
    mov     edi, 1; nmemb
    call    _calloc
    mov     [rbx], rax
    mov     eax, [rbp+var_18]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_28]
    add     rdx, rax
    mov     eax, [rbp+var_14]
    mov     [rdx+8], eax
    lea     rdi, aPleaseInputCon; "Please input content: "
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_18]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     eax, [rax+8]
    movsxd  rdx, eax; nbytes
    mov     eax, [rbp+var_18]
    shl     rax, 4
    mov     rcx, rax
    mov     rax, [rbp+var_28]
    add     rax, rcx
    mov     rax, [rax]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_20], eax
    cmp     [rbp+var_20], 0
    jle     short loc_16CA
    mov     eax, [rbp+var_18]
    shl     rax, 4
    mov     rdx, rax
    mov     rax, [rbp+var_28]
    add     rax, rdx
    mov     rax, [rax]
    mov     edx, [rbp+var_20]
    movsxd  rdx, edx
    sub     rdx, 1
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_16D4
loc_16CA:
    mov     eax, 0
    call    sub_1521
loc_16D4:
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
    add     rsp, 28h
    pop     rbx
    pop     rbp
    retn
sub_153B endp

