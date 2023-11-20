sub_C46 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_1C], 0
    jmp     loc_D88
loc_C69:
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202040
    mov     eax, [rdx+rax]
    test    eax, eax
    jnz     loc_D84
    lea     rdi, aSize; "size: "
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_18]
    mov     edi, eax
    call    sub_BE0
    mov     [rbp+var_18], eax
    cmp     [rbp+var_18], 0
    jle     loc_D7F
    cmp     [rbp+var_18], 1000h
    jle     short loc_CBF
    mov     [rbp+var_18], 1000h
loc_CBF:
    mov     eax, [rbp+var_18]
    cdqe
    mov     esi, 1; size
    mov     rdi, rax; nmemb
    call    calloc
    mov     [rbp+var_10], rax
    cmp     [rbp+var_10], 0
    jnz     short loc_CE6
    mov     edi, 0FFFFFFFFh; status
    call    exit
loc_CE6:
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, unk_202040
    mov     dword ptr [rdx+rax], 1
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    mov     rcx, rax
    lea     rax, unk_202044
    mov     edx, [rbp+var_18]
    mov     [rcx+rax], edx
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    mov     rcx, rax
    lea     rax, qword_202048
    mov     rdx, [rbp+var_10]
    mov     [rcx+rax], rdx
    mov     eax, [rbp+var_1C]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, qword_202048
    mov     rax, [rdx+rax]
    and     eax, 0FFFh
    mov     [rbp+var_14], eax
    mov     eax, [rbp+var_14]
    mov     esi, eax
    lea     rdi, aTheLowbitsOfHe; "The lowbits of heap leak check : %x\n"
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_1C]
    mov     esi, eax
    lea     rdi, aTheIndexOfTick; "the index of ticket is %d \n"
    mov     eax, 0
    call    printf
loc_D7F:
    mov     eax, [rbp+var_1C]
    jmp     short loc_D92
loc_D84:
    add     [rbp+var_1C], 1
loc_D88:
    cmp     [rbp+var_1C], 0Fh
    jle     loc_C69
loc_D92:
    mov     rsi, [rbp+var_8]
    xor     rsi, fs:28h
    jz      short locret_DA6
    call    __stack_chk_fail
locret_DA6:
    leave
    retn
sub_C46 endp

