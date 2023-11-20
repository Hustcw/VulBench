edit proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "Index: "
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    get_int
    mov     [rbp+var_10], eax
    cmp     [rbp+var_10], 0
    js      loc_121F
    cmp     [rbp+var_10], 0Fh
    jg      loc_121F
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_10]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_121F
    lea     rdi, aContent; "Content: "
    mov     eax, 0
    call    printf
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_10]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     eax, [rax+8]
    mov     ecx, eax
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_10]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    mov     esi, ecx
    mov     rdi, rax
    call    read_n
    mov     [rbp+var_C], eax
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_10]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rdx, [rax]
    mov     eax, [rbp+var_C]
    cdqe
    add     rax, rdx
    mov     byte ptr [rax], 0
    lea     rdi, aEditSuccess; "Edit success :)"
    call    puts
    jmp     short loc_122B
loc_121F:
    lea     rdi, aInvalidIndex; "Invalid index :("
    call    puts
loc_122B:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1240
    call    __stack_chk_fail
locret_1240:
    leave
    retn
edit endp

