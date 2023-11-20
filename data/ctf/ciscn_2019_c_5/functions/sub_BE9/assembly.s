sub_BE9 proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     eax, cs:dword_20204C
    cmp     eax, 10h
    jle     short loc_C18
    lea     rdi, aEnough; "Enough!"
    call    puts
loc_C18:
    lea     rdi, aPleaseInputThe; "Please input the size of story: "
    call    puts
    lea     rax, [rbp+var_1C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_1C]
    test    eax, eax
    jns     short loc_C55
    mov     eax, [rbp+var_1C]
    cmp     eax, 50h ; 'P'
    jle     short loc_C55
    mov     edi, 0; status
    call    exit
loc_C55:
    mov     eax, cs:dword_20204C
    mov     edx, [rbp+var_1C]
    cdqe
    shl     rax, 4
    mov     rcx, rax
    lea     rax, unk_202060
    mov     [rcx+rax], edx
    mov     ebx, cs:dword_20204C
    mov     eax, [rbp+var_1C]
    cdqe
    mov     rdi, rax; size
    call    malloc
    mov     rcx, rax
    movsxd  rax, ebx
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202068
    mov     [rdx+rax], rcx
    lea     rdi, aPleaseInputeTh; "please inpute the story: "
    call    puts
    mov     eax, [rbp+var_1C]
    movsxd  rdx, eax; nbytes
    mov     eax, cs:dword_20204C
    cdqe
    shl     rax, 4
    mov     rcx, rax
    lea     rax, unk_202068
    mov     rax, [rcx+rax]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     eax, cs:dword_20204C
    add     eax, 1
    mov     cs:dword_20204C, eax
    lea     rdi, aDone; "Done!"
    call    puts
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_D05
    call    __stack_chk_fail
loc_D05:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
sub_BE9 endp

