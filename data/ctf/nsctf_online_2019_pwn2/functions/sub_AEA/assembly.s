sub_AEA proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    lea     rdi, aInputTheSize; "Input the size"
    call    puts
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    test    eax, eax
    jle     short loc_B8E
    mov     eax, [rbp+var_C]
    cmp     eax, 3FFh
    jg      short loc_B8E
    mov     eax, [rbp+var_C]
    cdqe
    mov     rdi, rax; size
    call    malloc
    mov     rdx, rax
    lea     rax, qword_202090
    mov     [rax], rdx
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax; n
    lea     rax, qword_202090
    mov     rax, [rax]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    mov     edx, [rbp+var_C]
    lea     rax, unk_202040
    mov     [rax], edx
    lea     rdi, aAddSuccess; "Add success"
    call    puts
    jmp     short loc_B9A
loc_B8E:
    lea     rdi, aSizeError; "Size error!"
    call    puts
loc_B9A:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_BAF
    call    __stack_chk_fail
locret_BAF:
    leave
    retn
sub_AEA endp

