sub_C0E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    jmp     short loc_C48
loc_C2E:
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jz      short loc_C50
    add     [rbp+var_C], 1
loc_C48:
    cmp     [rbp+var_C], 0Fh
    jle     short loc_C2E
    jmp     short loc_C51
loc_C50:
    nop
loc_C51:
    cmp     [rbp+var_C], 0Fh
    jle     short loc_C68
    lea     rdi, aYouCanTAddAnym; "you can't add anymore."
    call    _puts
    jmp     loc_D5D
loc_C68:
    lea     rdi, aLength; "length: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_10]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_10]
    cmp     eax, 7Fh
    jle     short loc_CA3
    mov     eax, [rbp+var_10]
    cmp     eax, 10000h
    jle     short loc_CB4
loc_CA3:
    lea     rdi, aInvalidSize; "invalid size"
    call    _puts
    jmp     loc_D5D
loc_CB4:
    mov     eax, [rbp+var_10]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rcx, rax
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    mov     [rax+rdx*8], rcx
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jnz     short loc_D01
    lea     rdi, aMallocFailed; "malloc failed."
    call    _puts
    mov     edi, 0FFFFFFFFh; status
    call    _exit
loc_D01:
    mov     eax, [rbp+var_10]
    movsxd  rdx, eax; n
    lea     rax, unk_2020C0
    mov     ecx, [rbp+var_C]
    movsxd  rcx, ecx
    mov     rax, [rax+rcx*8]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rdi, aYourNote; "your note:"
    call    _puts
    mov     eax, [rbp+var_10]
    mov     ecx, eax
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     esi, ecx
    mov     rdi, rax
    call    sub_B20
    lea     rdi, aDone; "done."
    call    _puts
loc_D5D:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_D71
    call    ___stack_chk_fail
locret_D71:
    leave
    retn
sub_C0E endp

