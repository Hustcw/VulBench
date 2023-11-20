uadd proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 120h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edx, 1Ch; n
    mov     esi, offset aPleaseInputThe; "please input the note size: "
    mov     edi, 1; fd
    call    _write
    mov     eax, 0
    call    input_choice
    mov     [rbp+var_114], eax
    cmp     [rbp+var_114], 100h
    jle     short loc_400C0E
    mov     edx, 12h; n
    mov     esi, offset aStopHeapAbuse; "Stop heap abuse!!\n"
    mov     edi, 1; fd
    call    _write
    mov     edi, 0; status
    call    _exit
loc_400C0E:
    mov     [rbp+var_11C], 0
    jmp     short loc_400C21
loc_400C1A:
    add     [rbp+var_11C], 1
loc_400C21:
    cmp     [rbp+var_11C], 0Fh
    jg      short loc_400C4D
    mov     eax, [rbp+var_11C]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    mov     eax, [rax]
    test    eax, eax
    jnz     short loc_400C1A
loc_400C4D:
    cmp     [rbp+var_11C], 0Fh
    jle     short loc_400C74
    mov     edx, 10h; n
    mov     esi, offset aTooMuchNote; "Too much note!!\n"
    mov     edi, 1; fd
    call    _write
    mov     edi, 0; status
    call    _exit
loc_400C74:
    mov     eax, [rbp+var_11C]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    add     rax, 8
    mov     edx, 90h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rax, [rbp+s]
    mov     edx, 100h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     eax, [rbp+var_114]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rcx, rax
    mov     eax, [rbp+var_11C]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 602178h
    mov     [rax], rcx
    mov     edx, 18h; n
    mov     esi, offset aPleaseInputThe_0; "Please input the title: "
    mov     edi, 1; fd
    call    _write
    lea     rax, [rbp+s]
    mov     esi, 90h
    mov     rdi, rax
    call    input2addr
    mov     edx, 1Ah; n
    mov     esi, offset aPleaseInputThe_1; "Please input the content: "
    mov     edi, 1; fd
    call    _write
    mov     eax, [rbp+var_114]
    movsxd  rcx, eax
    mov     eax, [rbp+var_11C]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 602178h
    mov     rax, [rax]
    mov     rdx, rcx; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    test    rax, rax
    jns     short loc_400D77
    mov     edi, 1; status
    call    _exit
loc_400D77:
    mov     eax, [rbp+var_11C]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    mov     dword ptr [rax], 1
    mov     eax, [rbp+var_11C]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    lea     rdx, dword_6020E4[rax]
    mov     eax, [rbp+var_114]
    mov     [rdx], eax
    mov     [rbp+var_118], 0
    jmp     short loc_400E22
loc_400DCC:
    mov     eax, [rbp+var_118]
    cdqe
    movzx   ecx, [rbp+rax+s]
    mov     eax, [rbp+var_118]
    movsxd  rsi, eax
    mov     eax, [rbp+var_11C]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, rsi
    add     rax, 6020E8h
    mov     [rax], cl
    mov     eax, [rbp+var_118]
    cdqe
    movzx   eax, [rbp+rax+s]
    test    al, al
    jz      short loc_400E30
    add     [rbp+var_118], 1
loc_400E22:
    cmp     [rbp+var_118], 90h
    jle     short loc_400DCC
    jmp     short loc_400E31
loc_400E30:
    nop
loc_400E31:
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400E4A
    call    ___stack_chk_fail
locret_400E4A:
    leave
    retn
uadd endp

