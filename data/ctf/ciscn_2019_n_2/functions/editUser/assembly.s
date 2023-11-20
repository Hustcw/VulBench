editUser proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     edi, offset aIndex; "Index:"
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    readNum
    mov     [rbp+var_14], eax
    cmp     [rbp+var_14], 2
    jg      short loc_400C63
    cmp     [rbp+var_14], 0
    jns     short loc_400C6D
loc_400C63:
    mov     edi, 1; status
    call    exit
loc_400C6D:
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_400D02
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    add     rax, 602068h
    mov     eax, [rax]
    test    eax, eax
    jz      short loc_400D02
    mov     edi, offset aName; "name:"
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_14]
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
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rbx, [rax]
    mov     eax, 0
    call    readNum
    mov     [rbx+10h], rax
    mov     edi, offset asc_4012CE; ":)"
    call    puts
    jmp     short loc_400D0C
loc_400D02:
    mov     edi, offset asc_4012B0; ":("
    call    puts
loc_400D0C:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
editUser endp

