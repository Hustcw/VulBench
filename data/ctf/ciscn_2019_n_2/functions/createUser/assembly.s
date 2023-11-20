createUser proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     [rbp+var_14], 0
    jmp     short loc_400B66
loc_400B30:
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    add     rax, 602068h
    mov     eax, [rax]
    test    eax, eax
    jnz     short loc_400B4D
    mov     eax, [rbp+var_14]
    mov     [rbp+var_18], eax
    jmp     short loc_400B6C
loc_400B4D:
    cmp     [rbp+var_14], 2
    jnz     short loc_400B62
    mov     edi, offset asc_4012B0; ":("
    call    puts
    jmp     loc_400C2B
loc_400B62:
    add     [rbp+var_14], 1
loc_400B66:
    cmp     [rbp+var_14], 2
    jle     short loc_400B30
loc_400B6C:
    mov     edi, 18h; size
    call    malloc
    mov     rdx, rax
    mov     eax, [rbp+var_18]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     [rax], rdx
    mov     edi, offset aName; "name:"
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_18]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    mov     esi, 8
    mov     rdi, rax
    call    myRead
    mov     edi, offset aAge; "age:"
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_18]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rbx, [rax]
    mov     eax, 0
    call    readNum
    mov     [rbx+10h], rax
    mov     eax, [rbp+var_18]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    mov     qword ptr [rax+8], 0
    mov     eax, [rbp+var_18]
    cdqe
    shl     rax, 4
    add     rax, 602068h
    mov     dword ptr [rax], 1
    mov     eax, [rbp+var_18]
    mov     esi, eax
    mov     edi, offset aIdxD; "idx: %d\n"
    mov     eax, 0
    call    printf
loc_400C2B:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
createUser endp

