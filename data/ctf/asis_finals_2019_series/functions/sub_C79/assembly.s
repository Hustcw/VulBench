sub_C79 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], 2
    jmp     loc_D4B
loc_C8D:
    mov     rax, cs:qword_202068
    mov     edx, [rbp+var_14]
    movsxd  rdx, edx
    shl     rdx, 3
    sub     rdx, 10h
    add     rax, rdx
    mov     rdx, [rax]
    mov     rax, cs:qword_202050
    imul    rax, rdx
    mov     [rbp+var_10], rax
    mov     rax, cs:qword_202068
    mov     edx, [rbp+var_14]
    movsxd  rdx, edx
    shl     rdx, 3
    sub     rdx, 8
    add     rax, rdx
    mov     rdx, [rax]
    mov     rax, cs:qword_202058
    imul    rax, rdx
    mov     [rbp+var_8], rax
    cmp     [rbp+var_10], 0
    jle     short loc_CFC
    mov     rax, 7FFFFFFFFFFFFFFFh
    sub     rax, [rbp+var_10]
    cmp     [rbp+var_8], rax
    jg      short loc_D17
loc_CFC:
    cmp     [rbp+var_10], 0
    jns     short loc_D25
    mov     rax, 7FFFFFFFFFFFFFFFh
    sub     rax, [rbp+var_10]
    cmp     [rbp+var_8], rax
    jge     short loc_D25
loc_D17:
    lea     rdi, aOverflowDetect; "Overflow detected"
    call    sub_A97
    jmp     short loc_D47
loc_D25:
    mov     rax, cs:qword_202068
    mov     edx, [rbp+var_14]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rcx, [rbp+var_10]
    mov     rdx, [rbp+var_8]
    add     rdx, rcx
    mov     [rax], rdx
loc_D47:
    add     [rbp+var_14], 1
loc_D4B:
    mov     eax, cs:dword_202060
    cmp     [rbp+var_14], eax
    jl      loc_C8D
    nop
    leave
    retn
sub_C79 endp

