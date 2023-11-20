sub_AC0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_18], 0
    mov     [rbp+var_14], 0
    jmp     short loc_AEB
loc_AE7:
    add     [rbp+var_14], 1
loc_AEB:
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2020A0
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_AE7
    cmp     [rbp+var_14], 9
    jle     short loc_B1F
    lea     rdi, aTheListIsFull; "The list is full"
    call    puts
    jmp     loc_C07
loc_B1F:
    lea     rdi, aInputTheSize; "Input the size:"
    call    puts
    lea     rax, [rbp+var_18]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_18]
    test    eax, eax
    jle     loc_BF8
    mov     eax, [rbp+var_18]
    cmp     eax, 3FFh
    jg      loc_BF8
    mov     eax, [rbp+var_18]
    cdqe
    mov     rdi, rax; size
    call    malloc
    mov     [rbp+s], rax
    cmp     [rbp+s], 0
    jz      loc_C06
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax; n
    mov     rax, [rbp+s]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    mov     eax, [rbp+var_14]
    cdqe
    lea     rcx, ds:0[rax*8]
    lea     rax, qword_2020A0
    mov     rdx, [rbp+s]
    mov     [rcx+rax], rdx
    mov     eax, [rbp+var_18]
    mov     ecx, eax
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, dword_202060
    mov     [rdx+rax], ecx
    lea     rdi, aInputTheConten; "Input the content:"
    call    puts
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax; nbytes
    mov     rax, [rbp+s]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rdi, aAddSuccess; "Add success"
    call    puts
    jmp     short loc_C06
loc_BF8:
    lea     rdi, aSizeError; "Size error!"
    call    puts
    jmp     short loc_C07
loc_C06:
    nop
loc_C07:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_C1B
    call    __stack_chk_fail
locret_C1B:
    leave
    retn
sub_AC0 endp

