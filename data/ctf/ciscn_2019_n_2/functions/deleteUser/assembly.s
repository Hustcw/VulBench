deleteUser proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edi, offset aIndex; "Index:"
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    readNum
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 2
    jg      short loc_400D43
    cmp     [rbp+var_4], 0
    jns     short loc_400D4D
loc_400D43:
    mov     edi, 1; status
    call    exit
loc_400D4D:
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_400D9F
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602068h
    mov     dword ptr [rax], 0
    mov     edi, offset asc_4012CE; ":)"
    call    puts
    jmp     short locret_400DA9
loc_400D9F:
    mov     edi, offset asc_4012B0; ":("
    call    puts
locret_400DA9:
    leave
    retn
deleteUser endp

