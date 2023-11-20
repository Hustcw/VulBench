sub_DA7 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_24], 0
    jmp     short loc_DE8
loc_DC7:
    mov     eax, [rbp+var_24]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202100
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_DF0
    add     [rbp+var_24], 1
loc_DE8:
    cmp     [rbp+var_24], 13h
    jle     short loc_DC7
    jmp     short loc_DF1
loc_DF0:
    nop
loc_DF1:
    cmp     [rbp+var_24], 14h
    jle     short loc_E08
    lea     rdi, aFull; "full"
    call    puts
    jmp     loc_EF3
loc_E08:
    lea     rdi, aLength; "length> "
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    sub_CD3
    mov     [rbp+var_1C], eax
    cmp     [rbp+var_1C], 7
    jle     short loc_E35
    cmp     [rbp+var_1C], 200h
    jle     short loc_E46
loc_E35:
    lea     rdi, aInvalidLength; "invalid length"
    call    puts
    jmp     loc_EF3
loc_E46:
    mov     eax, [rbp+var_1C]
    add     eax, 0Fh
    and     eax, 0FFFFFFF8h
    cdqe
    mov     [rbp+size], rax
    mov     rax, [rbp+size]
    mov     rdi, rax; size
    call    malloc
    mov     [rbp+var_10], rax
    mov     [rbp+var_20], 0
    jmp     short loc_E82
loc_E6E:
    mov     eax, [rbp+var_20]
    movsxd  rdx, eax
    mov     rax, [rbp+var_10]
    add     rax, rdx
    mov     byte ptr [rax], 0
    add     [rbp+var_20], 1
loc_E82:
    mov     eax, [rbp+var_20]
    cdqe
    cmp     rax, [rbp+size]
    jbe     short loc_E6E
    lea     rdi, aContent; "content> "
    mov     eax, 0
    call    printf
    mov     edx, [rbp+var_1C]
    mov     rax, [rbp+var_10]
    mov     esi, edx
    mov     rdi, rax
    call    sub_B41
    mov     eax, [rbp+var_24]
    cdqe
    lea     rcx, ds:0[rax*8]
    lea     rax, qword_202100
    mov     rdx, [rbp+var_10]
    mov     [rcx+rax], rdx
    mov     eax, [rbp+var_24]
    cdqe
    lea     rcx, ds:0[rax*8]
    lea     rax, qword_202060
    mov     rdx, [rbp+size]
    mov     [rcx+rax], rdx
    lea     rdi, aDone; "done"
    call    puts
loc_EF3:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_F07
    call    __stack_chk_fail
locret_F07:
    leave
    retn
sub_DA7 endp

