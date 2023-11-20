delete proc
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
    js      loc_1306
    cmp     [rbp+var_C], 0Fh
    jg      short loc_1306
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_1306
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    free
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     qword ptr [rax], 0
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     dword ptr [rax+8], 0
    lea     rdi, aDeleteSuccess; "Delete success :)"
    call    puts
    jmp     short loc_1312
loc_1306:
    lea     rdi, aInvalidIndex; "Invalid index :("
    call    puts
loc_1312:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1327
    call    __stack_chk_fail
locret_1327:
    leave
    retn
delete endp

