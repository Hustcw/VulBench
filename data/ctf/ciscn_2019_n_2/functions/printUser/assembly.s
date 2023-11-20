printUser proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edi, offset aIndex; "Index:"
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    readNum
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 3
    jg      short loc_400F7F
    cmp     [rbp+var_4], 0
    jns     short loc_400F89
loc_400F7F:
    mov     edi, 1; status
    call    exit
loc_400F89:
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    test    rax, rax
    jz      loc_401044
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602068h
    mov     eax, [rax]
    test    eax, eax
    jz      loc_401044
    mov     edi, offset asc_401332; "------------------------"
    call    puts
    mov     edi, offset aName_0; "name: "
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    mov     rdi, rax; s
    call    puts
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    mov     rdx, [rax+8]
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    mov     rax, [rax+10h]
    mov     rsi, rax
    mov     edi, offset aAgeLldMoneyLld; "age: %lld\nmoney: %lld\n"
    mov     eax, 0
    call    printf
    mov     edi, offset asc_401332; "------------------------"
    call    puts
    mov     edi, offset asc_4012CE; ":)"
    call    puts
    jmp     short loc_40104E
loc_401044:
    mov     edi, offset asc_4012B0; ":("
    call    puts
loc_40104E:
    nop
    leave
    retn
printUser endp

