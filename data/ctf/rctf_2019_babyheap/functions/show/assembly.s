show proc
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
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 0
    js      short loc_13A7
    cmp     [rbp+var_C], 0Fh
    jg      short loc_13A7
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_13A7
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    mov     rdi, rax; s
    call    puts
    jmp     short loc_13B3
loc_13A7:
    lea     rdi, aInvalidIndex; "Invalid index :("
    call    puts
loc_13B3:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_13C8
    call    __stack_chk_fail
locret_13C8:
    leave
    retn
show endp

